class PagesController < ApplicationController

  before_action :require_user, only: [:special]
  before_action :require_login, only: [:index]
  
  def index
    @quote = Quote.get_quote
    @records = current_user.records.order(date: :desc)
  end

  def faq
  end

  def updates
  end

  def comments
    @feedback = Feedback.new
  end

  def new_comment
    @comment = Feedback.new(feedback_params)
      if @comment.save
        flash[:success] = "Thank you for your feedback!"
        UserMailer.new_comment(current_user, @comment).deliver
        redirect_to profile_path
      else
        flash[:error] = "Something went wrong :( "
        render comments_path
      end
  end

  def about
    @users = User.all.count
    @records = Record.all.count
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment);
  end




end
