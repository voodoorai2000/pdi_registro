class InvitationsController < ApplicationController
  unloadable
  include AuthenticationEngine::Authentication::Invitation

  # GET /invitations/new
  def new
    @invitation = Invitation.new
    # constrain invitations to a specific site
    # @invitation.site_id = current_site.id
  end

  # POST /invitations
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      if current_user #&& current_user.active?
        UserMailer.deliver_invitation(@invitation, accept_url(@invitation.token))
        flash[:success] = t('invitations.flashs.success.create')
        redirect_to root_url
      else
        UserMailer.deliver_invitation_request(@invitation)
        flash[:success] = t('invitations.flashs.success.request')
        redirect_to root_url
      end
    else
      render :action => current_user ? 'new' : 'apply'
    end
  end

  # GET /invitations/apply
  def apply
    @invitation = Invitation.new
  end
end
