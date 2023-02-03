# frozen_string_literal: true

module Ratings
  class API < Grape::API
    version 'v1', using: :path
    prefix 'api'
    format :json

    resource :ratings do

      desc 'average grade the last two mother'
      get '/average-rate' do
       average_rate = Rating.average_rate_last_two_months
       { 'average_rate_last_two_mother': average_rate }
      end

      desc 'add ratings to a movie'
      params do
        requires :movie_id, type: String, desc: 'Movie id.'
        requires :grade, type: Integer, desc: 'Movie grade.'
      end

      post do
        Rating.create!({
          movie_id: params[:movie_id],
          grade: params[:grade]
        })
      end
    end
  end
end
