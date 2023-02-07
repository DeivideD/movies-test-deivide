class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date, :runtime, :genre, :parental_rating, :plot, :average_rating
  has_many :ratings

  def average_rating
    object.rating
  end
end
