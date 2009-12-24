class UsersController < ApplicationController
  unloadable
  include AuthenticationEngine::Authentication::User
  before_filter :find_user, :only => [:show, :edit, :update]
  before_filter :new_user, :only => [:new, :create]
  include AuthenticationEngine::Authorization::User

  # GET /account
  def show
  end

  # GET /signup
  def new
    redirect_to root_url and return unless REGISTRATION[:public]
  end

  # GET /account/edit
  def edit
  end

  # POST /account
  def create
    redirect_to root_url and return unless REGISTRATION[:public]

    @user.signup!(params[:user], SIGNUP[:prompt]) do |result|
      if result
        @user.deliver_activation_instructions!
        flash[:success] = t('users.flashs.success.create')
        redirect_to root_url
      else
        render :action => :new
      end
    end
  end

  # PUT /account
  def update
    @user.attributes = params[:user]
    language_changed = @user.preference.language_changed?

    @user.save do |result|
      if result
        set_language(@user.preference.language) if language_changed
        flash[:success] = t('users.flashs.success.update')
        redirect_to account_url
      else
        render :action => :edit
      end
    end
  end

  protected

  def find_user
    @user = @current_user
    redirect_to root_url if @user.blank?
  end

  def new_user
    @user = User.new
  end
end
