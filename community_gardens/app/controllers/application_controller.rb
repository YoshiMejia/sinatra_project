require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "c6e249ab453df5c9e0bbd0e1aec73fb34df09e054483bc5ac5e38481d14aa4c4"
  end

  get '/' do
    erb :index
  end

  get '/about' do
    if logged_in?
      @user = User.find(session[:user_id])
    end
    erb :about 
  end

  helpers do
    def redirect_if_not_logged_in 
      if !logged_in?
        redirect '/error'
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
