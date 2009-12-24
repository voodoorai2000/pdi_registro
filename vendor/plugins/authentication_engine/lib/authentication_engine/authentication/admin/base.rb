module AuthenticationEngine
  module Authentication
    module Admin
      module Base
        module ClassMethods
        
        end

        module InstanceMethods
          protected

          # Before filter to limit certain actions to administrators
          def require_admin
            return if admin?
            store_location
            flash[:error] = t('users.flashs.errors.admin_required')
            redirect_to root_url
            return false
          end
        end

        def self.included(receiver)
          receiver.extend ClassMethods
          receiver.send :include, InstanceMethods
          receiver.class_eval do
            before_filter :require_user
            # if you are using simple admin boolean on user
            before_filter :require_admin
          end
        end
      end
    end
  end
end