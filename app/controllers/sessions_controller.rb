class SessionsController < ApplicationController
  def new
  end

  def create
    #find the user by their email
    @user = User.find_by({ "email" => params["email"] })

    #if the email exists and the password matches, we can log in this user for the session
    if @user && BCrypt::Password.new(@user["password_digest"]) == params["password"]
      #unique session id for th user
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back, #{@user.first_name}!"
      redirect_to "/places" 
    else
      flash[:notice] = "Invalid email or password."
      redirect_to "/login"
    end
  end
  
  #logging the user out should terminate the session
  def destroy
  session[:user_id] = nil  
  flash[:notice] = "Succesfully logged out."
  redirect_to "/login"
  end
end
  