module AuthenticationEngine
  module Authentication
    module UserSession
      module ClassMethods
        
      end

      module InstanceMethods
        
      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.class_eval do
          before_filter :require_no_user, :only => [:new, :create]
          before_filter :require_user, :only => :destroy
        end
      end
    end
  end
end