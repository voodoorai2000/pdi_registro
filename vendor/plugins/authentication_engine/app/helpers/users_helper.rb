module UsersHelper
  def authentication_toggle
    link_to_function "Contraseña / OpenID", "$('password_box').toggle(); $('openid_box').toggle();"
  end
end
