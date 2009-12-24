module AuthenticationEngine
  module Authorization
    module User
      module ClassMethods
        
      end

      module InstanceMethods
        protected

        def new_user
          @user = ::User.new
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.class_eval do
          filter_access_to :all
          filter_access_to :show, :edit, :update, :attribute_check => true, :load_method => :current_user
          filter_access_to :new, :create do new_user; end
        end
      end
    end
  end
end