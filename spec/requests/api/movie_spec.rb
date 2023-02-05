require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  path '/api/v1/movies' do

    get '/api/v1/movies' do
      tags 'Movies'
      consumes 'application/json'

      response '200', 'ok' do
        let(:movie) { create(:movie) }
        run_test!
      end
    end

    get '/api/v1/movies/by-year' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: :year,
                type: :string,
                description: 'year'

      response '200', 'ok' do
        run_test!
      end
    end

    get '/api/v1/movies/by-genre' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: :genre,
                type: :string,
                description: 'genre'

      response '200', 'ok' do
        run_test!
      end
    end

    get '/api/v1/movies/parental-rating' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: :parental,
                type: :string,
                description: 'parental-rating'

      response '200', 'ok' do
        run_test!
      end
    end

    get '/api/v1/movies/best-rating-by-genre' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: :parental,
                type: :string,
                description: 'genre'

      response '200', 'ok' do
        run_test!
      end
    end

    get '/api/v1/movies/search' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: :parental,
                type: :string,
                description: 'title'

      response '200', 'ok' do
        run_test!
      end
    end

    get '/api/v1/ratings/average-rate' do
      tags 'Movies'
      consumes 'application/json'
      response '200', 'ok' do
        run_test!
      end
    end

    post '/api/v1/movies/' do
      tags 'Movies'
      consumes 'application/json'

      parameter name: :movie, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          release_date: { type: :date }
        },
        required: [ 'title', 'release_date' ]
      }

      response '201', 'ok' do

        let(:movie) { create(:movie) }
        run_test!
      end
    end
  end
end
