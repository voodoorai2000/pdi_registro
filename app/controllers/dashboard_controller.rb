class DashboardController < ApplicationController
  before_filter :require_user
  
  def index
    @user_regions = User.top_ranking(5)
  end
  
end
