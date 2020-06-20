require "sinatra/base"
require "sinatra/flash"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "mealplanner"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end
 
  helpers do

    def valid_username?(username)
      if !User.find_by(:username => username)
        true
      else
        false
      end
    end

    def valid_password?(password)
      if password.length > 5
        true
      else
        false
      end
    end

    def current_user
      @current_user ||= User.find_by(:username => session[:username]) if session[:username]
    end

    def login(username, password)
      user = User.find_by(:username => username)

      if user && user.authenticate(password)
        session[:username] = user.username
      else
        flash[:error] = "Username or password is incorrect, please try again."
        redirect "/login"
      end

    end

    def logged_in?
      !!current_user
    end

    def logout!
      session.clear
      redirect "/"
    end

  end
end