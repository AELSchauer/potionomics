class HomeController < ApplicationController
  def index
    @cupboards = current_user.cupboards.order(:updated_at)
  end
end
