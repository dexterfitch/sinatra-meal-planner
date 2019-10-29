class UsersController < ApplicationController

  get '/users/edit' do
    erb :"users/edit"
  end

  get '/signup' do
    erb :'users/new'
  end

  post '/users' do
    @user = User.new
    @user.username = params[:username]
    @user.password = params[:password]

    if valid_data?(@user.username, @user.password)
      @user.save
      redirect '/login'
    else
      flash[:error] = "Username already exists, or password does not meet minimum character length (6), please try again."
      redirect '/signup'
    end
  end

  put '/users' do
    @user = User.find(current_user.id)

    if User.find_by(:username => params[:username]) && current_user.username != params[:username]
      flash[:error] = "Username is taken, please try again"
      redirect '/users/edit'
    elsif params[:password].length < 6
      flash[:error] = "Password isn't long enough, minimum 6 characters"
      redirect '/users/edit'
    else
      @user.username = params[:username]
      @user.password = params[:password]
      @user.save
      redirect '/'
    end
  end
  
end