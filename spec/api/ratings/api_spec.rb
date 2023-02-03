require 'rails_helper'

RSpec.describe Ratings::API do
  let!(:movie) { create(:movie, title: "teste", release_date: Date.today) }
  let!(:rating) { create(:rating, movie: movie, grade: 5) }
  let!(:rating2) { create(:rating, movie: movie, grade: 3) }


  describe 'POST /api/v1/ratings/average-rate' do
    it 'adds rating to movie' do
      get "/api/v1/ratings/average-rate" 
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("4")
    end
  end


  describe 'POST /api/v1/ratings' do
    it 'adds rating to movie' do
      post "/api/v1/ratings", :params => { :movie_id => movie.id, grade: 2 }
      expect(response).to have_http_status(:created)
      expect(movie.ratings.count).to eq(3)
    end
  end
end
