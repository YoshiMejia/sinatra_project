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
    erb :welcome
  end

  get '/signup' do
    erb :'registrations/signup'
  end

  post '/signup' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    redirect '/' #NEEDS TO BE CHANGED TO USERS HOMEPAGE, ONCE ROUTE IS BUILT
  end




  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end