if config.respond_to?(:gems)
  config.gem 'authlogic', :lib => 'authlogic', :version => '>=2.1.1', :source => "http://gems.rubyforge.org" unless defined? Authlogic
  config.gem 'authlogic-oid', :lib => 'authlogic_openid', :version => '>=1.0.4', :source => "http://gems.rubyforge.org"
  config.gem 'ruby-openid', :lib => 'openid', :version => '>=2.1.7', :source => "http://gems.rubyforge.org"
  config.gem 'stffn-declarative_authorization', :lib => 'declarative_authorization', :version => '>=0.3.2.2', :source => 'http://gems.github.com'
  config.gem 'state_machine', :lib => 'state_machine', :version => '>=0.8.0', :source => "http://gems.rubyforge.org"
else
  begin
    require 'authlogic'
    require 'authlogic_openid'
    require 'ruby-openid'
    require 'declarative_authorization'
    require 'state_machine'
  rescue LoadError
    begin
      gem 'authlogic', '2.1.2'
      gem 'authlogic-oid', '1.0.4'
      gem 'ruby-openid', '2.1.7'
      gem 'declarative_authorization', '0.3.2.2'
      gem 'state_machine', '0.8.0'
    rescue Gem::LoadError
      puts "Install the authlogic, authlogic_oid, ruby-openid, declarative_authorization, and state_machine gems to enable authentication support"
    end
  end
end

require File.dirname(__FILE__) + '/lib/authentication_engine/localization'
require File.dirname(__FILE__) + '/lib/authentication_engine/authentication/base'
require File.dirname(__FILE__) + "/lib/authentication_engine/authorization/base"

config.to_prepare do
  ApplicationController.helper LayoutHelper
end
