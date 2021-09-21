class PlantsController < ApplicationController

    #create - make new plant objects

    get '/plants/new' do
        erb :'/plants/new'
    end

    post '/plants' do
        if params[:name].empty? || params[:info].empty?
            erb :'errors/empty_error'
        else
            @plant = Plant.create(name: params[:name], description: params[:info], user_id: session[:user_id])
            @plant.save
            @user = User.find_by(id: @plant.user_id)
            erb :'/plants/index' #"garden"
        end
    end

    #read - view plant page and/or plants
    get '/plants' do
        redirect_if_not_logged_in
        @user = User.find_by(id: session[:user_id])
#show page for viewing one plant? index shows all plants, each one has a link to 'plant profile' which shows if any other users have the same plant? plant.find_by(name: plant_name) then iterate thru and show all User names w that plant.
        erb :'/plants/index'
    end

    #edit - edit the user's plants


    #delete - delete the user's plants (checkbox form?)
    
    
end #class ender