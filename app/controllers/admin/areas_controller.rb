class Admin::AreasController < InheritedResources::Base
  before_filter :require_admin
  layout "admin"
end
