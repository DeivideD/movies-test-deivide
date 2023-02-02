class Movie < ApplicationRecord
  has_many :ratings dependent: :delete_all

  validates :title, :release_date, presence: true

  after_find :calculate_rating

  scope :by_release_date, -> { 
    group("DATE_PART('year', release_date)").count 
    # .max_by{|k,v| v}
  }
  
  scope :by_year, -> (data) { 
    where("DATE_PART('year', release_date) = ? ", data) 
    
  }

  def calculate_rating 
    if self.ratings.count.zero?
      self.rating = 0
    else
      self.rating = self.ratings.average(:grade)
    end
  end
end
