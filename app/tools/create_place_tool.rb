class CreatePlaceTool < RubyLLM::Tool
  description "Use this tool when we are receiving place information from the request. If the place does not exist in the database, it creates a new one"
  parameter :name, description: "The name of the lake/river/body of water for fishing"
  parameter :latitude, description: "The latitude of the lake/river/body of water for fishing. Preferably a specific and known fishing spot (e.g. 35.236500)"
  parameter :longitude, description: "The longitude of the lake/river/body of water for fishing. Preferably a specific and known fishing spot (e.g. 138.997140)"
  parameter :trip_id, description: "This is the id provided from the prompt for the instance of a trip"


  def execute(name:, latitude:, longitude:, trip_id:)
    # the actual work
    trip = Trip.find(trip_id)
    place = Place.find_or_create_by(name: name)
    place.update(latitude: latitude, longitude: longitude)
    trip.place = place
    if trip.save
      trip.generate_image_url
      # tell the ai that we made a new trip and provide the trip info for the llm to create the final response
      { success: true, trip_id: trip.id}
    else
      # tell the ai what went wrong
      { success: false, errors: trip.errors.full_messages}
    end
  end
end
