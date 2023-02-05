class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date, :runtime, :genre, :parental_rating, :plot, :average_rating, :total_ratings

  def total_ratings
    object.ratings.count
  end

  def average_rating
    object.rating
  end
end
