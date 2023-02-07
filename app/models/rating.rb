class Rating < ApplicationRecord
  belongs_to :movie

  validates_numericality_of :grade, :greater_than => 0, :less_than => 6
  validates :movie, presence: true, if: :movie_id

  after_save :calculate_rating

  scope :average_rate_last_two_months, -> {
    where(created_at: 2.months.ago.beginning_of_day..Time.zone.now.end_of_day)
    .average(:grade)
  }

  def calculate_rating 
    movie = self.movie
    movie.rating = movie.ratings.average(:grade)
    movie.save!
  end
end
