class EntriesController < ApplicationController

  def index
    @entries = Entry.where(user_id: session["user_id"])
  end

  def show
    @entry = Entry.find(params[:id])
    if @entry.user_id != session["user_id"]
      flash["notice"] = "Access denied."
      redirect_to "/places"
    end

  def new
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["user_id"] = session["user_id"]
    @entry["place_id"] = params["place_id"]
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

  

end
