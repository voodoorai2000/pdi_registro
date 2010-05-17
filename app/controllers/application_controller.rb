# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  unloadable # only need to set unloadable for engine classes or modules
  include AuthenticationEngine::Authentication::Base
  include AuthenticationEngine::Authorization::Base
  include AuthenticationEngine::Localization

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  
  protected
  
  def require_admin
    return if admin?
    store_location
    flash[:error] = "Lo sentimos, solo los administradores pueden hacer eso."
    redirect_to root_url
    return false
  end
end
