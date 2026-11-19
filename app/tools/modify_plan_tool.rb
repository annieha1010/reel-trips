class ModifyPlanTool < RubyLLM::Tool
  description "Use this tool when you are asked to modify, update, or change anything from the plan. return only a message with the response_message. do not show the updated plan content in the message "
  parameter :content,
            description: "the complete updated trip plan formatted in markdown(including both the requested change and the existing unchanged details) "
  parameter :date, description: "display the exact same time and date"

  def initialize(trip)
    @trip = trip
  end

  def execute(date:, content:)
    if @trip.update(plan: content, date: date)
      { success: true, response_message: "Plan sucessfully changed!" }
    else
      { success: false, errors: @trip.errors.full_messages }
    end
  end
end
