class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if(params[:sort_by] == "title")
      @movies = Movie.order(:title)
    elsif(params[:sort_by] == "release_date")
      @movies = Movie.order(:release_date)
    else
      @movies = Movie.all
    end
    
    
    @all_ratings = Movie.all_ratings
    @ticked_ratings = params[:ratings] if params.has_key? 'ratings'
    if @ticked_ratings
      @movies = Movie.where(:rating => @ticked_ratings.key("1"))
    end
    
    
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def bar
    var = Movie.new(movie_params)
    @movie = Movie.find_by title: var.title
    if(@movie != nil)
      # @movie.update(title: var, rating: var, release_date: var)
      @movie.title = var.title
      if(var.release_date!=nil)
        @movie.release_date = var.release_date
      else
        @movie.release_date = @movie.release_date 
      end
      if(var.rating!=nil)
        @movie.rating = var.rating
      else
        @movie.rating = @movie.rating 
      end
      @movie.save
      redirect_to movies_path
    else
      flash[:notice] = "Movie does not exist."
      redirect_to foo_path
    end
  end
  
  def foo
    @movie = Movie.new
  end
  
  def func
    var = Movie.new(movie_params)
    @movie1 = Movie.find_by rating: var.rating
    @movie2 = Movie.find_by release_date: var.release_date
    if(@movie1 != nil || @movie2 != nil)
      while(@movie1 != nil)
      # flash[:notice] = "Movie does not exist."
        @movie1.destroy
        @movie1 = Movie.find_by rating: var.rating
      end
      while(@movie2 != nil)
      # flash[:notice] = "Movie does not exist."

        @movie2.destroy
        @movie2 = Movie.find_by release_date: var.release_date
      end
    else
      flash[:notice] = "Movie does not exist."
    end
    redirect_to movies_path
  end
  
end
