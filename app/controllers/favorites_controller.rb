class FavoritesController < ApplicationController

  get '/favorites' do
    @favorites = current_user.favorites
    erb :"favorites/favorites"
  end

  post '/favorites' do
    @favorite = current_user.favorites.build(params)
    if !Favorite.find_by(:href => @favorite.href)
      @favorite.save
      redirect '/favorites'
    else
      flash[:error] = "You've saved this recipe already!"
      redirect '/favorites/new'
    end
  end

  get '/favorites/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :"favorites/new"
    end
  end

  put '/favorites/:id' do
    @favorite = Favorite.find(params[:id])
    @favorite.title = params[:title]
    @favorite.href = params[:href]
    @favorite.thumbnail = params[:thumbnail]
    @favorite.save
    redirect "/favorites"
  end

  get '/favorites/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      @favorite = Favorite.find(params[:id])
      if @favorite.user_id == current_user.id
        erb :"favorites/edit"
      else
        flash[:error] = "You are not authorized to edit that post."
        redirect "/favorites"
      end
    end
  end

  get '/favorites/:id/delete' do

    if !logged_in? 
      redirect "/login"
    else
      if !Favorite.find(params[:id])
        flash[:error] = "Favorite not found!"
        redirect '/'
      else
        @favorite = Favorite.find(params[:id])
        if @favorite.user_id == current_user.id
          @favorite.destroy
          redirect "/favorites"
        else
          flash[:error] = "You are not authorized to delete that post."
          redirect "/favorites"
        end
      end
    end
  end

  get '/search' do
    erb :"favorites/search"
  end
  
end