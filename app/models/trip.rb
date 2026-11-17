class Trip < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :date, presence: true

  def self.system_prompt
    "You are an expert fisherman well-versed in fishing spots in Japan.\n
    I am a sometimes a beginner/hobbyist looking for information regarding fishing spots in Japan.\n
    You take a date and a location and provide responses in markdown, structured as follows (one short paragraph per item):\n
    Information on the location, fish to be found, and equipment necessary. You take into account the unique factors of the location and season"
  end
end
