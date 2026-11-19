class MessagesController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @message = Message.new(message_params)
    @message.trip = @trip
    @message.role = "user"
    if @message.save
      create_assistant_message
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to trip_path(@trip)}
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.update()}
        format.html { render "trips/show", status: :unprocessable_entity }
      end
    end
  end

  def create_assistant_message
    rubyllm_chat = RubyLLM.chat(model: 'gpt-4.1')
    #  @trip = Trip.find(params[:trip_id])
    modify_plan_tool = ModifyPlanTool.new(@trip)
    rubyllm_chat.with_tools(modify_plan_tool)
    # Provide chat history
    @trip.messages.each do |message|
      rubyllm_chat.add_message(role: message.role, content: message.content)
    end
    # Give system prompt
    rubyllm_chat.with_instructions(Message.system_prompt + "Given the user's request, make the appropriate changes to the following Plan: '#{@trip.plan}'")
    response = rubyllm_chat.ask(@message.content)
    @ai_message = Message.create(
      role: "assistant",
      content: response.content,
      trip: @trip
    )
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
