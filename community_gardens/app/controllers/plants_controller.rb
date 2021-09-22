class PlantsController < ApplicationController

    
    #create - make new plant objects
    get '/plants/new' do
        erb :'/plants/new'
    end

    post '/plants' do
        if params[:name].empty? || params[:info].empty?
            erb :'errors/empty_error'
        else
            @plant = Plant.create(name: params[:name].downcase, description: params[:info], user_id: session[:user_id])
            @plant.save
            @user = User.find_by(id: @plant.user_id)
            @plants = @user.plants
            erb :'/plants/index' #"garden"
        end
    end

    #read - view plant page and/or plants
    get '/plants' do #view garden 
        redirect_if_not_logged_in
        @user = User.find_by(id: session[:user_id])
        @plants = @user.plants
        @users_plants = Plant.where(user_id: @user.id)
        erb :'/plants/index'
    end

    #edit - edit the user's plants
    get '/plants/:id' do 
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        @plant = Plant.find_by(id: params[:id])
        @plant_users = Plant.where(name: @plant.name)
        #grabbing the users who have this plant
        @plant_users = @plant_users.where.not(user_id: @user.id)
        #removing the current user from the variable
        if @plant.user == @user
            erb :'/plants/show'
        else
            erb :'/errors/user_error'
        end
    end

    get '/plants/:id/edit_plant' do #view form for editing
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        @plant = Plant.find_by(id: params[:id])
        if @plant.user == @user
            erb :'/plants/edit'
        else
            erb :'/errors/user_error'
        end
    end

    patch '/plants/:id' do
        redirect_if_not_logged_in
        @plant = Plant.find(params[:id]) 
        @user = User.find(session[:user_id])
        if @plant.user == @user
            @plant.update(params["plant"])
            @plant.save
            redirect "/plants/#{@plant.id}"
        else
            erb :'/errors/user_error'
        end
    end


    delete '/plants/:id/delete_garden' do
        @user = User.find(session[:user_id])
        @plants = @user.plants
        @users_plants = Plant.where(user_id: @user.id)
        @users_plants.destroy_all
        redirect "users/#{@user.id}/homepage"
    end

    delete '/plants/:id/delete_plant' do
        @plant = Plant.find(params[:id]) 
        @plant.destroy
        redirect '/plants'
    end 
    
    
end #class ender