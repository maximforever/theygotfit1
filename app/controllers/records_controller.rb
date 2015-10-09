class RecordsController < ApplicationController

    before_action :require_user, only: [:new]

    def index
      @records = Record.all
    end

    def new
      @user = current_user
      @record = Record.new
    end

    def create
       @record = Record.new(record_params)
       @record.weight = @record.to_pounds if @record.pounds == "false"
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


    def search
    end

    def find
#      @records = Record.master(params[:start_weight], params[:end_weight]).page(params[:page])
      @records = Kaminari.paginate_array(Record.master(params[:start_weight], params[:end_weight], params[:pounds], params[:gender])).page(params[:page]).per(1)
    end

    private

    def record_params
      params.require(:record).permit(:photo, :weight, :height, :pounds, :inches, :caption, :date, :user_id)
    end


end
