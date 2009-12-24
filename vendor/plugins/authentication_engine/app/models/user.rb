class User < ActiveRecord::Base
  include AuthenticationEngine::User
  include AuthenticationEngine::User::Authorization
  include AuthenticationEngine::User::StateMachine

  # Just keep this in model in case of being called again in customized User model
  # if someone wants to modify configs definded in AuthenticationEngine::User module
  # or add their own configs.
  acts_as_authentic

  # # Authorization plugin
  # acts_as_authorized_user
  # acts_as_authorizable
  # authorization plugin may need this too, which breaks the model
  # attr_accesibles need to merged; this resets it
  # attr_accessible :role_ids
end
