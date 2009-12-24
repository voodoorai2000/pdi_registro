module AuthenticationEngine
  module User
    # require authlogic
    module ClassMethods
      def password_salt_is_changed?
        password_salt_field ? "#{password_salt_field}_changed?".to_sym : nil
      end
    end

    # require authlogic
    module InstanceMethods
      # We need to distinguish general signup or invitee signup
      def signup!(user, prompt, &block)
        return save(true, &block) if session_class.activated? && openid_complete?
        return signup_by_openid!(user, &block) if respond_to?(:signup_by_openid!) && user && !user[:openid_identifier].blank?
        return signup_as_invitee!(user, prompt, &block) if respond_to?(:signup_as_invitee!) && user && user[:invitation_id]
        signup_without_credentials!(user, &block)
      end

      # Since users have to activate themself with credentials,
      # we should signup without session maintenance and save with block.
      def signup_without_credentials!(user, &block)
        unless user.blank?
          self.name = user[:name] unless user[:name].blank?
          self.email = user[:email] unless user[:email].blank?
        end
        # only one user can be admin
        self.admin = true if self.class.count == 0
        save_with_block(true, &block)
      end

      # We need to save with block to prevent double render/redirect error.
      def save_with_block(logged, &block)
        if logged
          result = save_without_session_maintenance
          yield(result) if block_given?
          result
        else
          save(true, &block)
        end
      end

      # we only have name and email for a new created user
      def to_param
        "#{id}-#{name.parameterize}"
      end

      private

      # one admin at least
      def deny_admin_suicide
        raise 'admin suicided' if self.class.count(&:admin) <= 1
      end
    end

    # require authlogic
    module PasswordResetMethods
      # Since password reset doesn't need to change openid_identifier,
      # we save without block as usual.
      def reset_password_with_params!(user)
        self.class.ignore_blank_passwords = false
        self.password = user[:password]
        self.password_confirmation = user[:password_confirmation]
        save
      end

      def deliver_password_reset_instructions!
        reset_perishable_token!
        UserMailer.deliver_password_reset_instructions(self)
      end
    end

    # require authlogic-oid
    module AuthlogicOpenIdMethods
      def self.included(receiver)
        receiver.class_eval do
          # extend/include methods of authlogic-oid in case of no methods found
          extend AuthlogicOpenid::ActsAsAuthentic::Config
          include AuthlogicOpenid::ActsAsAuthentic::Methods

          attr_accessible :openid_identifier

          merge_validates_length_of_login_field_options :if => :validate_login_with_openid?
          merge_validates_format_of_login_field_options :if => :validate_login_with_openid?

          openid_required_fields [:nickname, :email]
          openid_optional_fields [:fullname, :dob, :gender, :postcode, :country, :language, :timezone]

          # hack by alias_method_chain for authlogic-oid
          alias_method_chain :attributes_to_save, :reliability
          alias_method_chain :map_openid_registration, :persona_fields
        end
      end

      def signup_by_openid!(user, &block)
        unless user.blank?
          self.name = user[:name] unless user[:name].blank?
          self.email = user[:email] unless user[:email].blank?
          self.openid_identifier = user[:openid_identifier]
        end
        save_with_block(false, &block)
      end

      # check when user's credentials changed
      def validate_login_with_openid?
        validate_password_with_openid?
      end

      def openid_complete?
        session_class.controller.params[:open_id_complete] && session_class.controller.params[:for_model]
      end

      private

      # fetch persona from openid.sreg parameters returned by openid server if supported
      # http://openid.net/specs/openid-simple-registration-extension-1_0.html
      def map_openid_registration_with_persona_fields(registration)
        self.nickname ||= registration["nickname"] if respond_to?(:nickname) && !registration["nickname"].blank?
        self.login ||= registration["nickname"] if respond_to?(:login) && !registration["nickname"].blank?
        self.email ||= registration["email"] if respond_to?(:email) && !registration["email"].blank?
        self.name ||= registration["fullname"] if respond_to?(:name) && !registration["fullname"].blank?
        self.first_name ||= registration["fullname"].split(" ").first if respond_to?(:first_name) && !registration["fullname"].blank?
        self.last_name ||= registration["fullname"].split(" ").last if respond_to?(:last_name) && !registration["fullname"].blank?
        self.birthday ||= registration["dob"] if respond_to?(:birthday) && !registration["dob"].blank?
        self.gender ||= registration["gender"] if respond_to?(:gender) && !registration["gender"].blank?
        self.postcode ||= registration["postcode"] if respond_to?(:postcode) && !registration["postcode"].blank?
        self.country ||= registration["country"] if respond_to?(:country) && !registration["country"].blank?
        self.language ||= registration["language"] if respond_to?(:language) && !registration["language"].blank?
        self.timezone ||= registration["timezone"] if respond_to?(:timezone) && !registration["timezone"].blank?
      end

      # reject more protected attributes of model
      def attributes_to_save_with_reliability
        attrs_to_save = attributes_to_save_without_reliability
        attrs_to_save.reject { |k,v| [:admin, :invitation_limit].include?(k.to_sym) }
      end
    end

    # require authlogic-oid
    module ActivationMethods
      # Since openid_identifier= will trigger openid authentication,
      # we save with block.
      def activate!(user, prompt, &block)
        unless user.blank?
          self.login = user[:login]
          self.password = user[:password]
          self.password_confirmation = user[:password_confirmation]
          self.openid_identifier = user[:openid_identifier] if respond_to?(:openid_identifier)
          self.name = user[:name] unless self.invitation_id.blank?
          self.email = user[:email] unless self.invitation_id.blank? 
        end
        logged = prompt && validate_password_with_openid?
        save_with_block(logged, &block)
      end

      def deliver_activation_instructions!
        # skip reset perishable token since we don't set roles in signup!
        reset_perishable_token!
        UserMailer.deliver_activation_instructions(self)
      end

      def deliver_activation_confirmation!
        reset_perishable_token!
        UserMailer.deliver_activation_confirmation(self)
      end
    end

    # require authlogic-oid
    module InvitationMethods
      def self.included(receiver)
        receiver.class_eval do
          has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
          belongs_to :invitation

          validates_uniqueness_of :invitation_id, :allow_nil => true
          attr_accessible :invitation_id

          before_create :set_invitation_limit
        end
      end

      # Since invitee need to be activated with credentials,
      # we save with block.
      def signup_as_invitee!(user, prompt, &block)
        self.attributes = user if user
        logged = prompt && validate_password_with_openid?
        save_with_block(logged, &block)
      end

      def signup_as_requested_invitee!(user, &block)
        self.attributes = user if user
        save_with_block(true, &block)
      end

      def invitation_token
        invitation.token if invitation
      end

      def invitation_token=(token)
        self.invitation = Invitation.find_by_token(token)
      end

      def deliver_invitation_activation_notice!
        # return unless self.invitation
        UserMailer.deliver_invitation_activation_notice(self)
      end

      private

      def set_invitation_limit
        self.invitation_limit = 5
      end
    end

    module PreferenceMethods
      def self.included(receiver)
        receiver.class_eval do
          has_one :preference, :class_name => "Preference", :foreign_key => "user_id"
          accepts_nested_attributes_for :preference, :allow_destroy => true
          attr_accessible :preference_attributes
          after_create :create_default_preference
        end
      end

      def create_default_preference
        create_preference if Preference.table_exists? && preference.nil?
      end
    end

    # require declarative_authorization
    module Authorization
      def self.included(receiver)
        receiver.class_eval do
          has_and_belongs_to_many :roles

          using_access_control

          before_save :set_current_user_for_model_security
          # use after_save to create default role
          # every singed up user will have one role at least
          after_save :create_default_role
        end
      end

      def admin?
        roles.any? { |r| r.name == 'admin' }
      end

      def role_symbols
        (roles || []).map { |r| r.name.to_sym }
      end

      def assign_role(role)
        role_found = role.is_a?(::Role) ? role : ::Role.find_by_name(role.to_s)
        roles << role_found if role_found && !roles.include?(role_found)
        role_found
      end

      def map_roles(role_hash, skip_array=[])
        new_role_ids = role_ids
        role_hash.map do |name, token|
          next if skip_array.include?(name.to_s) # skip basic role
          role = ::Role.find_by_name(name.to_s)
          unless role.nil?
            new_role_ids.delete(role.id) if token == '0' or token == false
            new_role_ids.push(role.id) if token == '1' or token == true
          end
        end
        self.role_ids = new_role_ids
      end

      def has_role?(role_list=[])
        role_list.any? do |role|
          roles.map(&:name).include?(role)
        end
      end

      protected

      def set_current_user_for_model_security
        ::Authorization.current_user = self
      end

      def create_default_role
        return unless roles.empty?
        ::Role.first ? ::Role.first : ::Role.find_or_create_by_name(:name => 'member', :title => 'Member')
        assign_role(::Role.first)
      end
    end

    # require state_machine
    module StateMachine
      def self.included(receiver)
        receiver.class_eval do
          alias_method :signup_with_params!, :signup!
          alias_method :activate_with_credentials!, :activate!

          state_machine :initial => :created do
            after_transition :created => [:registered, :applied] do |user, transition|
              # disable perishable token reset for signup mail delivering
              user.class.disable_perishable_token_maintenance true
              #u.save false # persis the state
              user.save_without_session_maintenance false # persis the state
              user.class.disable_perishable_token_maintenance false
            end

            after_transition [:registered, :applied] => :approved do |user, transition|
              # disable perishable token reset for signup mail delivering
              user.class.disable_perishable_token_maintenance true
              #u.save false # persis the state
              user.save_without_session_maintenance false # persis the state
              user.class.disable_perishable_token_maintenance false
            end

            after_transition :approved => :invited do |user, transition|
              # disable perishable token reset for signup mail delivering
              user.class.disable_perishable_token_maintenance true
              #u.save false # persis the state
              user.save_without_session_maintenance false # persis the state
              user.class.disable_perishable_token_maintenance false
            end

            #event :signup do
            #  transition :created => :registered
            #end
            event :register do
              transition :created => :registered
            end

            event :apply do
              transition :created => :applied
            end

            event :approve do
              transition [:registered, :applied] => :approved
            end

            event :invite do
              transition [:approved] => :invited
            end

            event :activate do
              transition [:invited, :registered, :disabled, :archived] => :active
            end

            event :disable do
              transition :active => :disabled
            end

            event :archive do
              transition all => :archived
            end

            event :remove do
              transition :archived => :deleted
            end
          end

          # The state machine will define even name methods automatically ("signup" and "signup!" in this case).
          # Then our original "signup!" method will be overwrited and user signup will fail.
          # We must define "signup!" method again after the state_machine definition in User model,
          # or use alias_method_chain in module to resolve this situation. Same as "activate!"
          #alias_method_chain :signup!, :authentication

          alias_method_chain :signup!, :register
          alias_method_chain :signup_as_requested_invitee!, :apply
          alias_method_chain :activate!, :authentication
          alias_method_chain :approved?, :active
        end
      end

      # method chain procedure:
      # signup! (in controller) => signup! (state_machine of User) => signup_with_authentication!
      def signup_with_authentication!(user, prompt, &block)
        result = signup_with_params(user, prompt, &block)
        # fire "signup" event only when user is created/signed up successfully
        # since login, password and password_confirmation aren't required for signup,
        # skip run_action (save) of state_machine to avoid validation on update,
        # and return "final" result to avoid double render/redirect error
        signup_without_authentication! false if result
      end

      def signup_with_register!(user, prompt, &block)
        result = signup_without_register!(user, prompt, &block)
        # fire "register" event only when user is created/signed up successfully
        # since login, password and password_confirmation aren't required for signup,
        # skip run_action (save) of state_machine to avoid validation on update
        # and return "final" result to avoid double render/redirect error
        register false if result
      end

      def signup_as_requested_invitee_with_apply!(user, &block)
        result = signup_as_requested_invitee_without_apply!(user, &block)
        apply false if result
      end

      def activate_with_authentication!(user, prompt, &block)
        # validation will be affected by "active?", "approved?", and "confirmed?" methods of state machine,
        # skip validation of magic states of authlogic session,
        # otherwise user_session won't activate after "activate_with_credentials!"
        self.class.session_class.disable_magic_states true
        result = activate_with_credentials!(user, prompt, &block)
        # This "unless" condition will disable user_session validation of magic states forever
        # and we should write validations of each state for user session than use this hack
        unless respond_to?(:approved?) or respond_to?(:confirmed?)
          # turn on validation of magic states of authlogic session
          # since user may not be "approved" or "confirmed?" and cause validation of magic states
          self.class.session_class.disable_magic_states false
        end
        if result && !invitation_id.blank?
          apply
          approve
          invite
        end
        # fire "activate" event only when user is activated with credentials successfully
        # do run_action (save) of state_machine since user is "active" or "approved" before validation
        # and return "final" result to avoid double render/redirect error
        activate_without_authentication! if result
      end

      def approved_with_active?
        return true if active?
        approved_without_active?
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
      receiver.send :include, PasswordResetMethods
      receiver.send :include, AuthlogicOpenIdMethods
      receiver.send :include, ActivationMethods
      receiver.send :include, InvitationMethods
      receiver.send :include, PreferenceMethods
      receiver.class_eval do
        validates_presence_of :name

        attr_accessible :name, :email, :login, :password, :password_confirmation

        merge_validates_length_of_login_field_options :on => :update
        merge_validates_format_of_login_field_options :on => :update, :message => I18n.t('authlogic.error_messages.login_invalid')
        merge_validates_uniqueness_of_login_field_options :on => :update

        merge_validates_length_of_password_field_options :on => :update
        merge_validates_confirmation_of_password_field_options :on => :update, :if => :password_salt_is_changed?
        merge_validates_length_of_password_confirmation_field_options :on => :update

        before_destroy :deny_admin_suicide
      end
    end
  end
end