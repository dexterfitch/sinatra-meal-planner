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

    if valid_username?(@user.username) && valid_password?(@user.password)
      @user.save
      redirect '/login'
    else
      if !valid_username?(@user.username) && !valid_password?(@user.password)
        flash[:error] = "Username already exists and password does not meet minimum character length (6), please try again."
        redirect '/signup'
      elsif !valid_password?(@user.password)
        flash[:error] = "Password does not meet minimum character length (6), please try again."
        redirect '/signup'
      else
        flash[:error] = "Username already exists, please try again."
        redirect '/signup'
      end
    end
  end
  
end