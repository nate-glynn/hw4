class EntriesController < ApplicationController

  def index
    @entries = current_user.entries
  end

  def show
    @entries = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
    @place = Place.find(params[:place_id])
  end

  def create
    #@entry = current_user.entries.build(entry)
    #@entry = Entry.new
    #@entry["title"] = params["title"]
    #@entry["description"] = params["description"]
    #@entry["occurred_on"] = params["occurred_on"]
    #@entry["place_id"] = params["place_id"]
    #@entry["user_id"] = current_user.id

    @entry = current_user.entries.build(
      title: params["title"],
      description: params["description"],
      occurred_on: params["occurred_on"],
      place_id: params["place_id"], 
    )
    
    if params["uploaded_image"].present?
      @entry.uploaded_image.attach(params["uploaded_image"])
    end


    if @entry.save
      redirect_to "/places/#{@entry.place_id}"
    else
      render :new
    end

  end

end
