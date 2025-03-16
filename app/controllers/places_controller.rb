class PlacesController < ApplicationController

  def index
    @places = Place.where(user_id: session["user_id"])
  end

  def show
    @place = Place.find(params[:id])
    @entries = Entry.where(place_id: @place.id, user_id: session["user_id"]).with_attached_image
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place["user_id"] = session["user_id"]
    @place.save
    redirect_to "/places"
  end

end
