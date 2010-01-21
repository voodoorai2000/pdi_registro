module UserSessionsHelper
  def login_toggle
    link_to_function "Contraseña / OpenID", "$('password_box').toggle(); $('openid_box').toggle(); $('errorExplanation').toggle();"
  end
end
