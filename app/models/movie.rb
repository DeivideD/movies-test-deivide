class Movie < ApplicationRecord
  has_many :ratings, dependent: :delete_all

  validates :title, :release_date, presence: true

  scope :by_release_date, -> { 
    group("DATE_PART('year', release_date)").count 
    # .max_by{|k,v| v}
  }
  
  scope :by_year, -> (data) { 
    where("DATE_PART('year', release_date) = ? ", data) 
    
  }

end
