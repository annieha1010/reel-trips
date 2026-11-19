class CreatePlaceTool < RubyLLM::Tool
  description "Searches a place by keyword. If the place does not exist in the database, it creates a new one"
  param :name, desc: "The name of the lake/river/body of water for fishing"
  param :latitude, desc: "The latitude of the lake/river/body of water for fishing. Preferably a specific and known fishing spot (e.g. 35.236500)"
  param :longitude, desc: "The longitude of the lake/river/body of water for fishing. Preferably a specific and known fishing spot (e.g. 138.997140)"



  def initialize
    # Need places we already have (in order to avoid them)
    @places = Place.all

  end

  def execute(query:)
    query.split.each do |word|
      places = places.where("name ILIKE :q OR content ILIKE :q OR module ILIKE :q", q: "%#{word}%")
    end
  if places.empty?
    place = Place.create(
      name: name,
      latitude: latitude,
      longitude: longitude
    )

  end
    places.map { |challenge| { id: place.id, name: place.name, latitude: place.latitude, longitude: place.longitude } }
  end
end
