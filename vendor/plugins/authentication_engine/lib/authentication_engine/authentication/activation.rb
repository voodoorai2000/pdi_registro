module AuthenticationEngine
  module Authentication
    module Activation
      module ClassMethods

      end

      module InstanceMethods

      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.class_eval do
          before_filter :require_no_user, :only => [:new, :create]
        end
      end
    end
  end
end