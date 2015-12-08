class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_username(params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.email_confirmed
        if params[:remember_me]
          cookies.permanent[:auth_token] = @user.auth_token
        else
          cookies[:auth_token] = @user.auth_token 
        end
        redirect_to profile_path

      else
        flash[:error] = "Please check your email to activate your account."
        redirect_to login_path
      end
        
    else
      flash[:error] = "Invalid username or password."
      redirect_to login_path
    end
  end

  def destroy 
    cookies.delete(:auth_token)
    redirect_to root_path 
  end
end
