class Trip < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :date, presence: true

  attr_accessor :place_name, :new_plan

  def self.system_prompt
    "You are an expert fisherman well-versed in fishing spots in Japan.\n
    I am a sometimes a beginner/hobbyist looking for information regarding fishing spots in Japan.\n
    You take a date and a location and provide responses in markdown, structured as follows (one short paragraph per item):\n
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
