class EntriesController < ApplicationController
  
  def index
    if session["user_id"]
      @entries = Entry.where(user_id: session["user_id"])
    else
      flash["notice"] = "You must be logged in to view entries."
      redirect_to "/login"
    end
  end

  
  def new
    if session["user_id"]
      @entry = Entry.new
    else
      flash["notice"] = "You must be logged in to create an entry."
      redirect_to "/login"
    end
  end

  
  def create
    if session["user_id"]
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["user_id"] = session["user_id"]  # Assign entry to logged-in user
      @entry["place_id"] = params["place_id"]

      if @entry.save
        redirect_to "/places/#{params["place_id"]}"
      else
        flash["notice"] = "Error creating entry. Please try again."
        render "new"
      end
    else
      flash["notice"] = "You must be logged in to create an entry."
      redirect_to "/login"
    end
  end

  
  def show
    @entry = Entry.find(params[:id])
    if @entry.user_id != session["user_id"]
      flash["notice"] = "You do not have permission to view this entry."
      redirect_to "/places"
    end
  end

  
  def edit
    @entry = Entry.find(params[:id])
    if @entry.user_id != session["user_id"]
      flash["notice"] = "You do not have permission to edit this entry."
      redirect_to "/places"
    end
  end

  
  def update
    @entry = Entry.find(params[:id])
    if @entry.user_id == session["user_id"]
      @entry.update(title: params["title"], description: params["description"], occurred_on: params["occurred_on"])
      redirect_to "/places/#{@entry.place_id}"
    else
      flash["notice"] = "You do not have permission to update this entry."
      redirect_to "/places"
    end
  end

  
  def destroy
    @entry = Entry.find(params[:id])
    if @entry.user_id == session["user_id"]
      @entry.destroy
      redirect_to "/places/#{@entry.place_id}"
    else
      flash["notice"] = "You do not have permission to delete this entry."
      redirect_to "/places"
    end
  end
end