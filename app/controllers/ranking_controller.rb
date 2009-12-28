class RankingController < ApplicationController
  
  def index
    @user_regions = User.ranking
  end
end
