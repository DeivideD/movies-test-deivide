class RatingSerializer < ActiveModel::Serializer
  belongs_to :movie
  
  attributes :id, grade
end
