class PagesController < ApplicationController

  before_action :require_user, only: [:special]

  def index
  end

  def special
    @user = current_user
  end

end
