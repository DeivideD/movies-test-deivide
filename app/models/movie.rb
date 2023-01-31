class Movie < ApplicationRecord
  has_many :ratings

  validates :title, :release_date, presence: true
end
