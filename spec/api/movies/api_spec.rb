require 'rails_helper'

RSpec.describe Movies::API do
  let(:parental_rating) { "D" }
  let(:genre) { "fantasy" }
  let!(:movie) { create(:movie, title: "teste1", release_date: Date.today, parental_rating: parental_rating) }
  let!(:movie2) { create(:movie, title: "teste2", release_date: Date.tomorrow, genre: genre) }
  let!(:movie3) { create(:movie, title: "teste3", release_date: 1.year.ago) }

  describe 'GET /api/v1/movies' do
    it 'returns all movies' do
      get "/api/v1/movies/"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste1")
      expect(response.body).to include("teste2")
      expect(response.body).to include("teste3")
    end
  end


  describe 'GET /api/v1/movies/year-more-release' do
    it 'returns year with more releases' do
      get "/api/v1/movies/year-more-release"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(Date.today.year.to_s)
    end
  end

  describe 'GET /api/v1/movies/by-year/:year' do
    it 'returns movies by year' do
      get "/api/v1/movies/by-year/#{Date.today.year}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste1")
      expect(response.body).to include("teste2")
      expect(response.body).not_to include("teste3")
    end
  end

  describe 'GET /api/v1/movies/by-genre/:genre' do
    it 'returns movies by genre' do
      get "/api/v1/movies/by-genre/#{genre}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste2")
    end
  end

  describe 'GET /api/v1/movies/by-parental_rating/:parental_rating' do
    it 'returns movies by parental rating' do
      get "/api/v1/movies/by-parental_rating/#{parental_rating}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste1")
    end
  end

  describe 'GET /api/v1/movies/count-by-year' do
    it 'returns movies by genre' do
      get "/api/v1/movies/count-by-year"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(Date.today.year.to_s)
    end
  end

  describe 'GET /best-rating-by-parental-rating/:parental_rating' do
    let!(:rating) { create(:rating, movie: movie, grade: 5) }
    it 'returns max rating movie by parental rating' do
      get "/api/v1/movies/best-rating-by-parental-rating/#{parental_rating}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste1")
    end
  end

  describe 'GET /best-rating-by-genre/:genre' do
    let!(:rating) { create(:rating, movie: movie2, grade: 5) }
    it 'returns max rating movie by genre' do
      get "/api/v1/movies/best-rating-by-genre/#{genre}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste2")
    end
  end

  describe 'GET /api/v1/movies/search' do
    it 'returns searched movie' do
      get "/api/v1/movies/search?title=2"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste2")
    end
  end

  describe 'GET /api/v1/movies/:id' do
    it 'returns movie using id' do
      get "/api/v1/movies/#{movie2.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste2")
    end
  end

  describe 'POST /api/v1/movies' do
    it 'returns movie using id' do
      post "/api/v1/movies", :params => { :title => "Any Name", release_date: Date.yesterday }
      expect(response).to have_http_status(:created)
      expect(Movie.count).to eq(4)
    end
  end

  describe 'DELETE /api/v1/movies' do
    it 'remove movie' do
      delete "/api/v1/movies/#{movie2.id}"
      expect(response).to have_http_status(:ok)
      expect(Movie.count).to eq(2)
    end
  end
end
