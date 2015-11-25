class PasswordResetsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "Check your email for instructions to reset your password."
    redirect_to root_url
  end

  def edit

    @user = User.find_by_password_reset_token!(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to login_path
      flash[:error] = "This password reset link is invalid."
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    
    if @user.password_reset_sent_at < 2.hours.ago 
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."

    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      if :password && :password_confirmation
        flash[:success] = "Your password has been updated. You can now log in."
        redirect_to login_path
        @user.password_reset_token = nil
        @user.save!
      else
        flash[:error] = "Your password can't be blank."
        redirect_to edit_password_reset_url(@user.password_reset_token)
      end
    else
      render :edit
    end
  end

end
