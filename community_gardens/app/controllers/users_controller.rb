class UsersController < ApplicationController

#create
get '/signup' do 
    if !logged_in? 
        erb :'/registrations/signup' 
    else #if user is logged into session
        @user = User.find(session[:user_id]) #search class for acct by current session user_id
        redirect "users/#{@user.id}/homepage" 
    end
end

post '/signup' do #create user
    if params[:name].empty? || params[:email].empty?  || params[:password].empty? 
        erb :'/errors/empty_error'
        #redirect to specific "empty field" error if the params are empty?
    else #if the params are not empty, create user
        @user = User.create(:name => params[:name], :address => params[:address], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect "users/#{@user.id}/homepage" 
    end 
end

get '/login' do #login link from welcome page
    @user = User.find(session[:user_id])
    if !logged_in? #if not logged in
        erb :'sessions/login' #get loginpage
    elsif !@user == current_user #validate user 
        erb :'/errors/user_error'
    else
        #if they are logged in, render that user's homepage
        redirect to "/users/#{@user.id}/homepage"
    end
end

post '/login' do
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password]) #if user exists, redirect to their homepage
        session[:user_id] = @user.id
        redirect to "/users/#{@user.id}/homepage"
    else
        redirect to '/signup'
    end
end

#delete
get '/logout' do
    if logged_in?
        session.destroy
        erb :index
    else
        erb :index
    end
    
end

#read
get '/users/:id/homepage' do #greeting once logged in
    redirect_if_not_logged_in #gives error message
    @user = User.find(params[:id]) #search class for acct
    @plants = Plant.all
    if @user == current_user #validate session id
        erb :'/users/show'
    else
        erb :'/errors/user_error'
    end
end

get '/users/:id/edit_profile' do #edit account details
    redirect_if_not_logged_in
    @user = User.find(params[:id]) 
    if @user == current_user
        erb :'users/edit'
    else
        erb :'/errors/user_error'
    end
end

patch '/users/:id' do
    if params["user"]["name"].empty? || params["user"]["address"].empty? || params["user"]["email"].empty? || params["user"]["password"].empty?
        erb :'/errors/empty_error'
    else
        @user = User.find(params[:id]) 
        @user.update(params["user"])
        @user.id = params["id"]
        @user.save
        redirect "users/#{@user.id}/homepage"
    end
end

end #class ender