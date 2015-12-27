class RecordsController < ApplicationController

    before_action :require_user, only: [:delete]
    before_action :require_account, only: [:new]

    def index
      @records = Record.all
    end

    def new
      @user = current_user
      @record = Record.new
    end

    def create
      
      @record = Record.new(record_params)
      @record.other_photos = params[:other_photos]

      if @record.pounds == "false" || !@record.pounds
        @record.weight = @record.to_pounds
        @record.pounds = true
      end

      if @record.inches == "false" || !@record.inches
        @record.height = @record.to_inches
        @record.inches = true
      end


      


      @record.user_id = current_user.id
      if @record.save
        redirect_to record_path(@record.id)
      else
        render new_record_path
      end
    end

    def show
      @record = Record.find(params[:id])
      @user = User.find_by_id(@record.user_id)
      @records = @user.records.order(date: :desc) if @user 
      @next_record = Record.where('user_id = ? AND date > ?', @user.id, @record.date).first
      @previous_record = Record.where('user_id = ? AND date < ?', @user.id, @record.date).last
    end

    def delete
      @record = Record.find(params[:id])
      @record.destroy
      redirect_to profile_path
      flash[:success] = "The record has been deleted"
    end


    def search
    end

    def find
#     @records = Record.master(params[:start_weight], params[:end_weight]).page(params[:page])
      pull = Record.master(params[:start_weight], params[:end_weight], params[:pounds], params[:gender], params[:height], params[:inches])
      @records = Kaminari.paginate_array(pull).page(params[:page]).per(1)
      @pages = @records.total_pages
    end

    private

    def record_params
      params.require(:record).permit(:photo, :weight, :height, :pounds, :inches, :caption, :date, :user_id, {:other_photos =>[] })
    end


end
