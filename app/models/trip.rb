class Trip < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :date, presence: true
end
