class UsersController < ApplicationController

before_action :require_user, only: [:edit]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.imperial = true
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/users'
    else
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @records = @user.records.order(date: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to preferences_path
    else
      render 'edit'
    end
  end



  private

  def user_params
      params.require(:user).permit(:name, :username, :password, :password_confirmation, :age, :zipcode, :gender, :email, :imperial)
  end


end
