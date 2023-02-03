# frozen_string_literal: true

module Movies
  class API < Grape::API
  
    version 'v1', using: :path
    prefix 'api'
    format :json

    resource :movies do
      desc 'returns all movies'
      get do
        Movie.all.page(params[:page]).per(params[:per])
      end

      desc 'Show the year that had more films'
      get '/year-more-release' do
        year_movies = Movie.by_release_date.max_by{|k,v| v}

        { year: year_movies[0].to_i, movies:year_movies[1] }
      end


      desc 'Show the movies by year'
      get '/by-year/:year' do
        Movie.by_year(params[:year]).page(params[:page]).per(params[:per])
      end

      desc 'searches a movie using title'
      params do
        optional :title, type: String, desc: 'search term'
      end

      get '/search' do
        movies = Movie.where("title ILIKE '%#{params[:title]}%'")

        if movies.any?
          movies.first
        else
          error! 'nothing for this search', :internal_server_error
        end
      end

      desc 'Show information about a particular movie'
      params do
        requires :id, type: String, desc: 'movie ID.'
      end

      get '/:id' do
        movie = Movie.find_by_id(params[:id])

        if movie
          movie
        else
          error! 'not found', :internal_server_error
        end
      end

      desc 'Create a movie.'
      params do
        requires :title, type: String, desc: 'Movie title.'
        requires :release_date, type: Date, desc: 'Movie release date'
        optional :runtime, type: String, desc: 'Movie runtime'
        optional :genre, type: String, desc: 'Movie genre'
        optional :parental_rating, type: String, desc: 'Movie'
        optional :plot, type: String, desc: 'Movie'
      end

      post do
        Movie.create!({
          title: params[:title],
          release_date: params[:release_date],
          runtime: params[:runtime],
          genre: params[:genre],
          parental_rating: params[:parental_rating],
          plot: params[:plot]
        })
      end

      desc 'Delete a movie.'
      params do
        requires :id, type: String, desc: 'movie ID.'
      end
      delete ':id' do
        Movie.find(params[:id]).destroy
      end
    end
  end
end
