require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "c6e249ab453df5c9e0bbd0e1aec73fb34df09e054483bc5ac5e38481d14aa4c4"
  end

  get "/" do
    erb :welcome
  end

end