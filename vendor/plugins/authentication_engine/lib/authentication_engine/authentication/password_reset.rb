module AuthenticationEngine
  module Authentication
    module PasswordReset
      module ClassMethods
        
      end

      module InstanceMethods
        
      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.class_eval do
          before_filter :require_no_user
        end
      end
    end
  end
end