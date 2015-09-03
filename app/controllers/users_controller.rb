class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/users'
    else
      redirect_to new_user_path
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :username, :pass, :pass_confirm, :age, :zipcode, :gender)
  end


end
