class UsersController < ApplicationController

before_action :require_user, only: [:edit, :destroy, :update, :index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username.downcase!
    @user.email.downcase!
    @user.imperial = true
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "Please confirm your email address to continue."
        redirect_to root_url

    else
      render new_user_path
    end
  end

  def show
    @user = User.find_by_username(params[:username])
    @records = @user.records.order(date: :desc) if @user 
  end

  def edit
    @user = User.find_by_username(params[:username])
  end


  def update
    @user = User.find_by_username(params[:username])
    if @user.update_attributes(user_params)
      flash[:success] = "Your preferences have been updated!"
      redirect_to preferences_path
    else
      render 'edit'
    end
  end


  def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome to TheyGotFit! Your email has been confirmed.
        Please sign in to continue."
        redirect_to login_path
      else
        flash[:error] = "Sorry. This user does not exist."
        redirect_to root_path
      end
  end

  def destroy
    @user = User.find_by_username(params[:username])
    session[:user_id] = nil if @user.id == session[:user_id]
    @user.destroy
    flash[:error] = "Your account has been deleted."
    redirect_to root_path
  end

  def resend
    UserMailer.registration_confirmation(@user).deliver
  end


  private

  def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :age, :zipcode, :gender, :email, :imperial)
  end


end
