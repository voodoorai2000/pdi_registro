module AuthenticationEngine
  module Authentication
    module User
      module ClassMethods
        
      end

      module InstanceMethods
        protected

        def public_signup
          redirect_to root_url unless REGISTRATION[:public]
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.class_eval do
          before_filter :public_signup, :only => [:new, :create]
          before_filter :require_no_user, :only => [:new, :create]
          before_filter :require_user, :only => [:show, :edit, :update]
        end
      end
    end
  end
end