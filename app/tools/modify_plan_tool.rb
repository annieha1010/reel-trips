class ModifyPlanTool < RubyLLM::Tool
  description "Use this tool when you are asked to modify, update, o change anything from the plan. pass the full updated plan formatted in clean markdown. Keeping all the unchanging section interact "
  parameter :content,
            description: "the complete updated trip plan formatted in markdown(including both the requested change and the existing unchanged details) "
  parameter :date, description: "display the exact same time and date"

  def initialize(trip)
    @trip = trip
  end

  def execute(date:, content:)
    if @trip.update(plan: content, date: date)
      { success: true }
    else
      { success: false, errors: @trip.errors.full_messages }
    end
  end
end
