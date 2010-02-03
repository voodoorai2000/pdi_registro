class ColaborateController < ApplicationController
  before_filter :require_user
  def index
    @user = current_user
  end
end
