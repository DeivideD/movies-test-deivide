class Movie < ApplicationRecord
  has_many :ratings

  validates :title, :release_date, presence: true
  
  scope :by_year, -> (data) { 
    where("DATE_PART('year', release_date) = ? ", data) 
  }

end
