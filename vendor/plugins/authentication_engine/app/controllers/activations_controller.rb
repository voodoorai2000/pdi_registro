class ActivationsController < ApplicationController
  unloadable
  include AuthenticationEngine::Authentication::Activation
  before_filter :find_invitation, :only => [:new, :create]

  # GET /accept/:invitation_token
  # GET /register/:activation_code
  def new
    if @invitation
      @user = @invitation.recipient
    elsif User.respond_to? :with_state
      @user = User.with_state(:registered).find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    else
      @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    end
    #raise Exception if @user.active?
  rescue Exception => e
    redirect_to root_url
  end

  
  def create
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    
    raise Exception if @user.active?
    
    @user.activate!(@user, ACTIVATION[:prompt]) do |result|
      if result
        @user.deliver_activation_confirmation!
        flash[:success] = "Su cuenta ha sido activada."
        redirect_to login_url
      else
        render :action => :new
      end
    end
  rescue Exception => e
    redirect_to root_url
  end
  
  protected

  def find_invitation
    return false unless params[:invitation_token]
    @invitation = Invitation.find_by_token!(params[:invitation_token])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url
  end
end