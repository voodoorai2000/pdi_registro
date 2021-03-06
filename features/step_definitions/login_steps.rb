Given /^"(.*)" una? usuari[oa] administradora?$/ do |name|
  #Given "I am a confirmed user \"#{name}\" with password \"secret\""
  u = User.new
  u.signup!({:name => name, :email => "#{name}@example.com"}, false) {}
  u.activate!({:login => name, :password => "secret", :password_confirmation => "secret"}, false) {}
  u.roles << Role.find_or_create_by_name('admin')
end

Dado /^que estoy logado como "(.*)"$/ do |nombre|
    user = Factory.build(:user, :name => nombre)
    user.signup!({:name => user.name, :email => user.email}, false) {}
    user.activate!({:login => user.name, :password => 'secret', :password_confirmation => 'secret'}, false) {}
    visit login_path
    fill_in "Usuario", :with => user.login
    fill_in "Contraseña", :with => 'secret'
    click_button "Entrar"
end

Dado /^que estoy logado$/ do
    Dado "que estoy logado como \"cualquier_nombre\""
end


Dado /^que me he registrado con éxito$/ do
  Given "I am an anonymous user"
  When "I go to the registration form"
  And "I fill in \"usuario\" with \"bob\""
  And "I fill in \"email\" with \"bob@example.com\""
  And "I fill in \"escriba su contraseña\" with \"secret\""
  And "I fill in \"confirmación contraseña\" with \"secret\""
  And "I press \"Enviar\""
  Then 'I should see "¡Su cuenta ha sido creada"'
end

Dado /^que he recibido el email de activacion$/ do
  Given "\"bob@example.com\" should receive an email"
  When "I open the email"
  Then "I should see \"activa tu cuenta\" in the email body"
end

Dado /^que sigo el link "([^\"]*)" en el email$/ do |link|
  visit_in_email(link)
end

Cuando /^relleno el resto de campos del formulario de activacion$/ do
  When "I fill in \"usuario\" with \"bob\""
  When "I fill in \"escriba su contraseña\" with \"secret\""
  When "I fill in \"confirmación contraseña\" with \"secret\""
end

Cuando /^activo mi cuenta$/ do
  user = User.last
  user.activate!({:login => user.login, :password => 'secret', :password_confirmation => 'secret'}, false) {}
end

Cuando /^me autentifico$/ do
  When "I go to the login page"
   And "I fill in \"usuario\" with \"bob\""
   And "I fill in \"contraseña\" with \"secret\""
   And "I press \"Entrar\""
end


Entonces /^vere el formulario de activacion$/ do
  response.should contain('Nombre') if controller.params[:invitation_token]
  response.should contain('Email') if controller.params[:invitation_token]
  response.should contain('Usuario')
  response.should contain('Escriba su contraseña')
  response.should contain('Confirmación contraseña')
  response.should contain('Open ID')
end
