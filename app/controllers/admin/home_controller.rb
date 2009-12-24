class Admin::HomeController < ApplicationController
  unloadable
  
  def dashboard
    render :layout => "admin"
  end
end
