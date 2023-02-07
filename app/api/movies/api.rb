# frozen_string_literal: true

module Movies
  class API < Grape::API
    version 'v1', using: :path
    prefix 'api'
    formatter :json, Grape::Formatter::ActiveModelSerializers
    format :json

    helpers do
      params :pagination do
        optional :page, type: Integer, desc: 'page request.'
        optional :per, type: Integer, desc: 'quantity per page.'
      end

      def show_colection(collection)
        return collection unless collection.nil?

        error! 'nothing for this search', :internal_server_error
      end
    end

    resource :movies do
      desc 'returns all movies'
      params do
        use :pagination
      end
      get do
        Movie.includes(:ratings).page(params[:page]).per(params[:per])
      end

      desc 'Show the movies by year'
      params do
        use :pagination
        requires :year, type: String, desc: 'year movie release date'
      end
      get '/by-year/:year' do
        movie = Movie.by_year(params[:year]).page(params[:page]).per(params[:per])

        show_colection(movie)
      end

      desc 'Show the movies by genre'
      params do
        use :pagination
        requires :genre, type: String, desc: 'Movie genre'
      end
      get '/by-genre/:genre' do
        movie = Movie.where("genre ILIKE '%#{params[:genre]}%'").page(params[:page]).per(params[:per])

        show_colection(movie)
      end

      desc 'Show the movies by parental rate'
      params do
        use :pagination
        requires :parental_rating, type: String, desc: 'Parental rating'
      end
      get '/by-parental_rating/:parental_rating' do
        movie = Movie.where(parental_rating: params[:parental_rating]).page(params[:page]).per(params[:per])

        show_colection(movie)
      end

      desc 'Count movie by year'
      get '/count-by-year' do
        year_movies = Movie.group("DATE_PART('year', release_date)").count
        show_colection(year_movies)
      end

      desc 'Movie ratings'
      get '/:id/ratings' do
        movie = Movie.find(params[:id])
        { movie: movie.title, total_ratings: movie.ratings.count, ratings: movie.ratings.select(:id, :grade)}
      end

      desc 'Show the year that had more movies'
      get '/year-more-release' do
        year_movies = Movie.group("DATE_PART('year', release_date)").count.max_by { |_k, v| v }

        { year: year_movies[0].to_i, movies: year_movies[1] }
      end

      desc 'Show highest rating movie by parental rating'
      params do
        use :pagination
        requires :parental_rating, type: String, desc: 'Movie parental rating'
      end

      get '/best-rating-by-parental-rating/:parental_rating' do
        movie = Movie.where(parental_rating: params[:parental_rating])
                .where.not(rating: nil)
                .order(:rating, :created_at).last

        show_colection(movie)
      end

      desc 'Show highest rating movie by genre'
      params do
        use :pagination
        requires :genre, type: String, desc: 'Movie genre'
      end

      get '/best-rating-by-genre/:genre' do
        movie = Movie.where("genre ILIKE ?", "%#{params[:genre]}%")
                .where.not(rating: nil)
                .order(:rating, :created_at).last

        show_colection(movie)
      end

      desc 'searches a movie using title'
      params do
        optional :title, type: String, desc: 'search term'
      end

      get '/search' do
        movies = Movie.where("title ILIKE ?", "%#{params[:genre]}%")

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

        show_colection(movie)
      end

      desc 'Create a movie.'
      params do
        requires :title, type: String, desc: 'Movie title.'
        requires :release_date, type: Date, desc: 'Movie release date'
        optional :runtime, type: String, desc: 'Movie runtime'
        optional :genre, type: String, desc: 'Movie genre'
        optional :parental_rating, type: String, desc: 'Movie parental rating'
        optional :plot, type: String, desc: 'Movie plot'
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
