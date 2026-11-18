class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.place_name.present?
      # TODO: does a place need other information filled in later on?
      @trip.place = Place.find_or_create_by(name: @trip.place_name.strip)
    end

    if @trip.place.present?
      response = generate_plan
      @trip.plan = response.content
    end

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @messages = @trip.messages.order(:created_at) # Load messages
    @message = Message.new # Load new message for form
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

  def update
    @trip = Trip.find(params[:id])
    if params[:trip][:new_plan].present?
      update_plan
    end
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
    # Provide update request

    # Give system prompt
    rubyllm_chat.with_instructions(Trip.edit_prompt + "Given the user's request, make the appropriate changes to the following Plan: '#{@trip.plan}'. Provide your response in markdown in the same format without any dressing around it. If the user does not specify something which may prompt a change, produce the same Plan that they already had")
    response = rubyllm_chat.ask(params[:trip][:new_plan])
    @trip.plan = response.content
    @trip.save
  end

  def generate_plan
    rubyllm_chat = RubyLLM.chat(model: 'gpt-4.1')
    rubyllm_chat.with_instructions(Trip.system_prompt)
    rubyllm_chat.ask("Create an itinerary for the following location: #{@trip.place.name} and date: #{@trip.date}")
  end

  def trip_params
    params.require(:trip).permit(:date, :place_name)
  end
end
