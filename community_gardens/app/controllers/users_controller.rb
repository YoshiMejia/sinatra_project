class UsersController < ApplicationController

get '/error' do
    erb :'/errors/error'
end

# get '/welcome' do #main page
#     erb :'welcome'
# end


#create
get '/signup' do 
    if !logged_in? #if not logged in
        erb :'/registrations/signup' #signup form
    else #if user is logged into session
        # binding.pry
        @user = User.find(session[:user_id]) #search class for acct by current session user_id
        redirect "users/#{@user.id}/homepage" 
    end
end

post '/signup' do #create user
    # binding.pry 
    # if params[:name] == "" || params[:email] == "" || params[:password] == ""
    if params[:name].empty? || params[:email].empty?  || params[:password].empty? 
        #check if .empty? works
        redirect '/error'
        #redirect to specific "empty field" error if the params are empty?
    else #if the params are not empty, create user
        @user = User.create(:name => params[:name], :address => params[:address], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect "users/#{@user.id}/homepage" 
    end
    
end


#there will be a list of plants and/or users on
#the homepage, which will iterate tru .all and give lists and links
#to other profiles

get '/login' do #login link from welcome page
    if !logged_in? #if not logged in
        erb :'sessions/login' #get loginpage
    else #if they are logged in, render that user's homepage
        # binding.pry
        @user = User.find(session[:user_id])
        @user = current_user #validate user
        redirect to "/users/#{@user.id}"
    end
end

post '/login' do
    # binding.pry
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

get '/users/:id' do 
    # binding.pry
    redirect_if_not_logged_in
    @user = User.find(params[:id]) #find correct user
    if !@user.nil? && @user == current_user #validate that the current user is correct
        redirect "users/#{@user.id}/homepage"
    end
end
#read
get '/users/:id/homepage' do #greeting once logged in
    redirect_if_not_logged_in #gives error message
    @user = User.find(params[:id]) #search class for acct
    @user = current_user #validate session id
    erb :'/users/show'
end

get '/users/:id/edit_profile' do #need to create link on profile view
    # binding.pry
    redirect_if_not_logged_in
    @user = User.find(params[:id]) 
    erb :'users/edit'
end

patch '/users/:id' do
    # binding.pry
    if params["user"]["name"].empty? || params["user"]["address"].empty? || params["user"]["email"].empty? || params["user"]["password"].empty?
        redirect '/error'
    else
        @user = User.find(params[:id]) 
        @user.update(params["user"])
        @user.id = params["id"]
        @user.save
        redirect "users/#{@user.id}/homepage"
    end
end

end #class ender