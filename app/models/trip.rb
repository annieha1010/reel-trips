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
    Your first job is to fetch the name of a real fishing location (river/lake etc.) along with its latitude and longitude (e.g. 35.236500, 138.997140, and ideally an actual known fishing spot if possible) based on the user's input. Provide the name, latitude, and longitude to CreatePlaceTool for the purpose of creating/updating a place instance.\n
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

  def season_image
    case date&.month
    when 3..5
      "spring.png"
    when 6..8
      "summer.png"
    when 9..11
      "autumn.png"
    else
      "winter.png"
    end
  end

  def generate_image_url
    # return if @trip.place.nil?
    url = "https://commons.wikimedia.org/w/index.php?search=#{place.name}&title=Special%3AMediaSearch&type=image"

    html_file = URI.parse(url).read
    html_doc = Nokogiri::HTML.parse(html_file)
    link = html_doc.search(".sdms-image-result").attr("href")

    link_file = URI.parse(link).read
    html_doc = Nokogiri::HTML.parse(link_file)
    self.image_url = html_doc.search("#file a img").attr("src")
    save
  end
end
