class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #verifies if email address is already taken
    if User.find_by({ "email" => params["email"]}).nil?
      #create new user if email is available
      @user = User.new
      @user["first_name"] = params["first_name"]
      @user["last_name"] = params["last_name"]
      @user["email"] = params["email"]
      @user["password_digest"] = BCrypt::Password.create(params["password"]) 

      #save and log in the new user
      if @user.save
        session[:user_id] = @user.id 
        flash[:notice] = "Welcome, #{@user.first_name}!"
        redirect_to "/places"
      else
        render :new
      end

    else
      #this would be the case that the email address is already taken
      flash[:notice] = "Email address is taken"
      redirect_to "/users/new"
    end
  end
end
