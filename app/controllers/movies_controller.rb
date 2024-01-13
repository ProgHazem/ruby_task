class MoviesController < ApplicationController
    def index
      @movies = if params[:actor_search]
                  Movie.where('actor LIKE ?', "%#{params[:actor_search]}%")
                else
                  Movie.left_joins(:reviews)
                       .group('movies.id')
                       .order(Arel.sql('AVG(reviews.stars) DESC NULLS LAST'))
                       .all
                end
    end
  end