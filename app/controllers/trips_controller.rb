class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    # raise

    # @place = Place.find(trip_params[:place_id])
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    # Need to create @trip.plan
    response = generate_plan
    @trip.plan = response.content
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def index
    @trips = Trip.all
  end

  private

  def generate_plan
    rubyllm_chat = RubyLLM.chat(model: 'gpt-4.1')
    rubyllm_chat.with_instructions(Trip.system_prompt)
    rubyllm_chat.ask("Create an itinerary for the following location: #{@trip.place.name} and date: #{@trip.date}")
  end

  def trip_params
    params.require(:trip).permit(:date, :place_id)
  end
end
