class Rating < ApplicationRecord
  belongs_to :movie

  validates_numericality_of :grade, :greater_than => 0, :less_than => 6
  validates :movie, presence: true

  after_save :calculate_rating


  def calculate_rating 
    movie = self.movie
    movie.rating = movie.ratings.average(:grade)
    movie.save!
  end
end
