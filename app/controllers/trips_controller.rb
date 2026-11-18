class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
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

    @place = @trip.place

    if @place&.latitude.present? && @place&.longitude.present?
      @markers = [
        {
          lat: @place.latitude,
          lng: @place.longitude
          # each of your markers will display a info window when clicked
          # info_window_html: render_to_string(partial: "/places/map_box", locals: { place: @place })
        }
      ]
    else
      @markers = []
    end
  end

  def index
    @trips = Trip.all
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to trips_path, status: :see_other
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
