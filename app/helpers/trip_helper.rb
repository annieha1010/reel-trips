module TripHelper
  def trip_status_badge(trip)
    if trip.date < Date.today
      "Completed"
    elsif trip.date <= Date.today + 7.days
      "Upcoming..."
    else
      return nil
    end
  end
end
