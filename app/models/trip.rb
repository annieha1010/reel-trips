class Trip < ApplicationRecord
  belongs_to :place, optional: true
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :date, presence: true

  attr_accessor :place_name, :new_plan

  # DELETE ME LATER!!!!!!!!!!!!!!!!!!!!
  # These are form-only for now.
  # Values aren’t saved, because they aren’t in trip_params.
  # When we have real columns delete this line.
  attr_accessor :experience, :fishing_style, :catch_policy

  def self.system_prompt
    "You are an expert fisherman well-versed in fishing spots in Japan.\n
    I am a sometimes a beginner/hobbyist looking for information regarding fishing spots in Japan.\n
    Your first job is to fetch the name of a body of water (river/lake etc.) based on the user's input (if the user inputs 'Osaka', you find a suitable river/lake/body of water for fishing near Osaka. Not Osaka proper) along with its latitude and longitude (e.g. 35.236500, 138.997140). Verify that the coordinates are accurate to the body of water. The coordinates should lead to a pin being dropped directly on the body of water. Provide the name, latitude, and longitude of the body of water to CreatePlaceTool for the purpose of creating/updating a place instance.\n
    Then, you take a date and a location and provide responses in markdown, structured as follows (one short paragraph per item):\n
    Information on the location, fish to be found, and equipment necessary. You take into account the unique factors of the location and season"
  end

  def self.edit_prompt
    "You are an assistant for refining the itineraries provided by another llm who was given the following prompt\n
    'expert fisherman well-versed in fishing spots in Japan.\n
    I am a sometimes a beginner/hobbyist looking for information regarding fishing spots in Japan.\n
    You take a date and a location and provide responses in markdown, structured as follows (one short paragraph per item):\n
    Information on the location, fish to be found, and equipment necessary. You take into account the unique factors of the location and season'."
  end
end
