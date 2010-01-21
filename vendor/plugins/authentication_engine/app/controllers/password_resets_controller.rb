class PasswordResetsController < ApplicationController
  unloadable
  include AuthenticationEngine::Authentication::PasswordReset
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  # GET /password_resets/new
  def new
    render
  end

  # GET /password_resets/1/edit
  def edit
    render
  end

  # POST /password_resets
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:success] = "Las Instrucciones para resetear su contraseña se han enviado a su email. Por favor compruebe su cuenta de correo."
      redirect_to root_url
    else
      flash[:error] = "No se ha encontrado ningún usuario con esa dirección de email"
      render :action => :new
    end
  end

  # PUT /password_resets/1
  def update
    if @user.reset_password_with_params!(params[:user])
      flash[:success] = "Contraseña actualizada correctamente"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Lo sentimos, pero no hemos encontrado su cuenta. Si está teniendo problemas, intente copiar y pegar la URL de su email en el navegador o vuelva a empezar el proceso de resetear la contraseña."
    redirect_to root_url
  end
end
