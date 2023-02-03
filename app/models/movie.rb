class Movie < ApplicationRecord
  has_many :ratings, dependent: :delete_all

  validates :title, :release_date, presence: true

  scope :by_release_date, -> { 
    group("DATE_PART('year', release_date)").count 
  }
  
  scope :by_year, -> (data) { 
    where("DATE_PART('year', release_date) = ? ", data) 
  }

end
