module AuthenticationEngine
  module Authentication
    module Admin
      module User
        module ClassMethods
        
        end

        module InstanceMethods
          protected

          def limited_signup
            redirect_to admin_root_url unless REGISTRATION[:limited]
          end
        end

        def self.included(receiver)
          receiver.extend ClassMethods
          receiver.send :include, InstanceMethods
          receiver.class_eval do
            before_filter :limited_signup, :only => [:new, :create]
          end
        end
      end
    end
  end
end