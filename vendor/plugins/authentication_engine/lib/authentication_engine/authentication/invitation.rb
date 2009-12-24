module AuthenticationEngine
  module Authentication
    module Invitation
      module ClassMethods
        
      end

      module InstanceMethods
        protected

        def private_signup
          redirect_to root_url unless REGISTRATION[:private]
        end

        def requested_signup
          redirect_to root_url unless REGISTRATION[:requested]
        end

        def private_or_requested_signup
          redirect_to root_url unless REGISTRATION[:private] or REGISTRATION[:requested]
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.class_eval do
          # access filter depending on configuration
          before_filter :private_signup, :only => [:new]
          before_filter :requested_signup, :only => [:apply]
          before_filter :private_or_requested_signup, :only => [:create]

          # require_user if only registered users can send invites
          before_filter :require_user, :only => [:new]
          # require_no_user if only non-registered users can request invitations
          before_filter :require_no_user, :only => [:apply]
        end
      end
    end
  end
end