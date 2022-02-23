class HomeController < ApplicationController
  before_action :set_user_root, only: :index

  def index
  end

  def publisher_dashboard
  end

  private

  def set_user_root
    if @current_publisher
      redirect_to publisher_dashboard_home_path and return
    else
      redirect_to publisher_dashboard_home_path and return
    end
  end
end
