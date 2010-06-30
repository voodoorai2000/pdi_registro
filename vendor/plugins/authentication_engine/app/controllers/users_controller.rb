class UsersController < ApplicationController
  unloadable
  include AuthenticationEngine::Authentication::User
  before_filter :find_user, :only => [:show, :edit, :update]
  before_filter :new_user, :only => [:new]
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
    
    @user = User.new(params[:user])
    @user.signup!(params[:user], SIGNUP[:prompt]) do |result|
      if result
        @user.deliver_activation_instructions!
        flash[:success] = "¡Su cuenta ha sido creada, por favor revise su email para seguir las instrucciones de activación!"
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
        if params[:colaborar]
          flash[:success] = "¡Gracias por colaborar nos pondremos en contacto contigo!"
          redirect_to dashboard_url
        else
          redirect_to account_url
          flash[:success] = "¡Cuenta actualizada!"
        end
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
