class Admin::InvitationsController < Admin::AdminController
  unloadable
  before_filter :find_invitation, :only => [:show, :edit, :update, :destroy, :deliver]

  def index
    @invitations = Invitation.find :all, :order => 'sender_id ASC, created_at DESC, sent_at ASC'
  end

  #def show
  #end

  #def edit
  #end

  #def new
  #  @invitation = Invitation.new
  #end

  #def create
  #  @invitation = Invitation.new(params[:invitation])
  #  if @invitation.save
  #    flash[:notice] = "Successfully created invitation."
  #    redirect_to admin_invitation_path(@invitation)
  #  else
  #    render :action => 'new'
  #  end
  #end

  #def update
  #  if @invitation.update_attributes(params[:invitation])
  #    flash[:notice] = "Successfully updated invitation"
  #    redirect_to admin_invitation_path(@invitation)
  #  else
  #    render :action => 'edit'
  #  end
  #end

  #def destroy
  #  @invitation.destroy
  #  flash[:notice] = "Successfully destroyed invitation."
  #  redirect_to admin_invitations_url
  #end

  def deliver
    if @invitation.approve_applicant
      @invitation.deliver_acception(accept_url(@invitation.token))
      flash[:success] = "Invitacion enviada."
      redirect_to admin_invitations_url
    else
      redirect_to admin_invitations_url
    end
  end

  protected

  def find_invitation
    @invitation = Invitation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_root_url
  end
end
