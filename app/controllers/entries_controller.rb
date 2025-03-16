class EntriesController < ApplicationController

  def index
    @entries = current_user.entries
  end

  def show
    @entries = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entr)
    
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = current_user.id
   
    if @entry.save
      redirect_to "/places/#{@entry.place_id}"
    else
      render :new
    end
    
  end

end
