class SessionsController < ApplicationController
  def new
  end

  def create
    # Find user by email
  @user = User.find_by({ "email" => params["email"] })

  # If user exists, check password
  if @user && BCrypt::Password.new(@user["password"]) == params["password"]
    session["user_id"] = @user["id"]
    flash["notice"] = "Welcome, #{@user["first_name"]}."
    redirect_to "/places"
  else
    flash["notice"] = "Invalid email or password."
    redirect_to "/login"
  end
end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Logged out successfully."
    redirect_to "/login"
  end
end
  