class PagesController < ApplicationController

  before_action :require_user, only: [:special]
  before_action :require_login, only: [:index]
  
  def index
    @quote = Quote.get_quote
    @records = current_user.records.order(date: :desc)
  end

  def special
    @user = current_user
  end

  def about
  end




end
