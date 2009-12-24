class Invitation < ActiveRecord::Base
  include AuthenticationEngine::Invitation

  # Authorization plugin
  # acts_as_authorizable
end
