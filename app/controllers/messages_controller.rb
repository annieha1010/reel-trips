class MessagesController < ApplicationController

  def create
    @trip = Trip.find(params[:trip_id])
    @message = Message.new(message_params)
    @message.trip = @trip
    @message.role = "user"
    if @message.save
      create_assistant_message
      redirect_to trip_path(@trip)
    else
      render "trips/show", status: :unprocessable_entity
    end
  end

  def create_assistant_message
    rubyllm_chat = RubyLLM.chat(model: 'gpt-4.1')
    # Provide chat history
    @trip.messages.each do |message|
      rubyllm_chat.add_message(role: message.role, content: message.content)
    end
    # Give system prompt
    rubyllm_chat.with_instructions(Message.system_prompt + "Given the user's request, make the appropriate changes to the following Plan: '#{@trip.plan}'. Provide your response in markdown in the same format unless additional clarification is necessary to alter the user's Plan.")
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
