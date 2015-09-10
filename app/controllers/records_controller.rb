class RecordsController < ApplicationController

    before_action :require_user, only: [:new]

    def new
      @user = current_user
      @record = Record.new
    end

    def create
       @record = Record.new(record_params)
       @record.user_id = current_user.id
       if @record.save
        redirect_to user_path(session[:user_id])
      else
        render new_record_path
      end
    end

    def show
      @record = Record.find(params[:id])
      @user = User.find_by_id(@record.user_id)
    end


    private

    def record_params
      params.require(:record).permit(:photo, :weight, :height, :pounds, :inches, :caption, :date, :user_id)
    end


end
