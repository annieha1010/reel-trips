class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    # @place = Place.find(trip_params[:place_id])
    @user = User.find(5) # refracter to get the current_user
    @trip = Trip.new(trip_params)
    @trip.user = @user
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

  def trip_params
    params.require(:trip).permit(:date, :place_id)
  end
end
