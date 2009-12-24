module AuthenticationEngine
  module Authentication
    # use ActionController::Filters to work with authentication
    # http://api.rubyonrails.org/classes/ActionController/Filters/ClassMethods.html
    module Base
      module ClassMethods

      end

      module InstanceMethods
        protected

        def current_user_session
          @current_user_session ||= ::UserSession.find
        end

        def current_user
          @current_user ||= current_user_session && current_user_session.record
        end

        def store_location
          session[:return_to] = request.request_uri
        end

        def redirect_back_or_default(default)
          redirect_to(session[:return_to] || default)
          session[:return_to] = nil
        end

        def require_user
          return if current_user
          store_location
          flash[:notice] = t('users.flashs.notices.login_required')
          redirect_to login_url
          return false
        end

        def require_no_user
          return unless current_user
          store_location
          flash[:notice] = t('users.flashs.notices.logout_required')
          redirect_to account_url
          return false
        end

        # Helper method to determine whether the current user is an administrator
        def admin?
          current_user && current_user.admin?
        end
      end

      module RestrictionMethods
        protected

        def limited_signup
          redirect_to root_url unless REGISTRATION[:limited]
        end

        def public_signup
          redirect_to root_url unless REGISTRATION[:public]
        end

        def limited_or_public_signup
          redirect_to root_url unless REGISTRATION[:limited] or REGISTRATION[:public]
        end

        def no_user_signup
          redirect_to root_url unless REGISTRATION[:private] or REGISTRATION[:requested] or REGISTRATION[:public]
        end
      end

      # Inclusion hook to make #current_user and #current_user_session
      # available as ActionView helper methods.
      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
        receiver.send :include, RestrictionMethods
        receiver.class_eval do
          helper_method :current_user_session, :current_user, :admin?
          filter_parameter_logging :password, :password_confirmation
        end
      end
    end
  end
end