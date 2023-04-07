class Apis::V1::MoviesController < ApplicationController
  #before_action :jwt_authenticate, only: [:create, :update, :destroy]

  def index
    @movies = Movie.all
    movies_array = Array.new

    @movies.each do |movie|
      movies_array << get_formatted_movie(movie)
    end

    render json: movies_array, status: 200
  end

  def show
    @movie = Movie.find(params[:id])
    render json: get_formatted_movie(@movie), status: 200 if @movie
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.genres = JSON.parse(movie_params[:genres])
    render json: @movie.errors unless @movie.save
    render json: get_formatted_movie(@movie), status: 201 if @movie.save
  end

  def update
    @movie = Movie.find(params[:id])
    render json: @movie.errors unless @movie.update(movie_params)
    render json: get_formatted_movie(@movie), status: 201 if @movie.update(movie_params)
  end

  def destroy
    @movie = Movie.find(params[:id])
    render json: @movie.errors unless @movie.destroy
    if @movie.destroy
      @movie.image.purge
      render json: "Movie and the movie poster deleted.", status: 200
    end
  end

  private
  def movie_params
    params.permit(:title, :rating, :image, :trailer_link, :year, :running_time, :genres, :description)
  end

  def get_formatted_movie(movie)
    formatted_movie = {
      id: movie.id,
      title: movie.title,
      rating: movie.rating,
      image: url_for(movie.image),
      trailer_link: movie.trailer_link,
      year: movie.year,
      running_time: movie.running_time,
      genres: movie.genres,
      description: movie.description
    }
  end
end
