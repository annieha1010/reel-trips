require "open-uri"
require "nokogiri"

class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      response = generate_plan
      @trip.plan = response.content
      @trip.save
      redirect_to trip_path(@trip)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @messages = @trip.messages.order(:created_at)
    @message = Message.new
    @place = @trip.place

    if @place&.latitude.present? && @place&.longitude.present?
      @markers = [
        {
          lat: @place.latitude,
          lng: @place.longitude
        }
      ]
    else
      @markers = []
    end
  end

  def index
    if params.dig(:search, :query).present?
      @trips = current_user.trips.where.not(place: nil).search_by_place(params[:search][:query])
    else
      @trips = current_user.trips.where.not(place: nil)
    end
  end

  def update
    @trip = Trip.find(params[:id])
    update_plan if params[:trip][:new_plan].present?
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render "trips/show", status: :unprocessable_entity
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_path, status: :see_other
  end

  private

  def update_plan
    rubyllm_chat = RubyLLM.chat(model: 'gpt-4.1')
    # Give system prompt
    rubyllm_chat.with_instructions(Trip.edit_prompt + "Given the user's request, make the appropriate changes to the following Plan: '#{@trip.plan}'. Provide your response in markdown in the same format without any dressing around it. If the user does not specify something which may prompt a change, produce the same Plan that they already had")
    response = rubyllm_chat.ask(params[:trip][:new_plan])
    @trip.plan = response.content
    @trip.save
  end

  def generate_plan
    rubyllm_chat = RubyLLM.chat(model: 'gpt-4.1')
    rubyllm_chat.with_tools(CreatePlaceTool)
    rubyllm_chat.with_instructions(Trip.system_prompt)
    rubyllm_chat.ask("User input: #{params[:trip][:place_name]}. This is the `trip_id`: #{@trip.id}. Once the CreatePlaceTool provides you a `place_id`, then Create an itinerary for that location and date: #{@trip.date}")
  end

  def trip_params
    params.require(:trip).permit(:date, :place_name)
  end
end
