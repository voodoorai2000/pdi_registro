Given /"([^\"]*)" is an anonymous user/ do |name|
  visit '/logout'
end

Given /^I have registered successfully$/ do
  Given "I am an anonymous user"
  When "I go to the registration form"
  And "I fill in \"usuario\" with \"bob\""
  And "I fill in \"email\" with \"bob@example.com\""
  And "I fill in \"escriba su contraseña\" with \"secret\""
  And "I fill in \"confirmación contraseña\" with \"secret\""

  And "I press \"Enviar\""
  Then "I should have a successful registration"
end

Given /^I have received an activation email$/ do
  Given "\"bob@example.com\" should receive an email"
  When "I open the email"
  Then "I should see \"activa tu cuenta\" in the email body"
end

Given /^I have successfully activated my account$/ do
  Given "I have registered successfully"
    And "I have received an activation email"
    And "I follow \"activa tu cuenta\" in the email"
  Then "I should have a successful activation"
  When "I fill in \"usuario\" with \"bob\""
  When "I fill in \"contraseña\" with \"secret\""
   And "I press \"Entrar\""
  And "I should be logged in"
end

Then /^I should see the registration form$/ do
  response.should contain('Nombre')
  response.should contain('Email')
end

Then /^I should see the activation form$/ do
  response.should contain('Nombre') if controller.params[:invitation_token]
  response.should contain('Email') if controller.params[:invitation_token]
  response.should contain('Usuario')
  response.should contain('Escriba su contraseña')
  response.should contain('Confirmación contraseña')
  response.should contain('Open ID')
end

Then /^I should have (an|\d*) errors?$/ do |amount|
  amount = 1 if amount == "an"
  response.should contain("#{amount} error")
end

Then /^I should have a successful registration$/ do
  Then 'I should see "¡Su cuenta ha sido creada"'
end

Then /^I should have an unsuccessful registration$/ do
  Then 'I should not see "¡Su cuenta ha sido creada"'
end

Then /^I should have a successful activation$/ do
  And 'I should see "Su cuenta ha sido activada"'
end

Then /^I should have an unsuccessful activation$/ do
  Then 'I should not see "Su cuenta ha sido activada"'
end

Then /^I should be logged in$/ do
  Then 'I should see "Tu Cuenta"'
end

Then /^I should not be logged in$/ do
  Then 'I should not see "Tu Cuenta"'
end

Then /^I should be logged out$/ do
  Then 'I should not be logged in'
  And 'I should see "¡Sesión cerrada!"'
end

Then /^I should see the home page$/ do
  Then 'I should see "Regístrate en el Partido de Internet"'
end

Then /^I should see my account page$/ do
  Then 'I should be on "the account page"'
  And 'I should see "Tu Cuenta"'
end

Then /^I should see my account editing page$/ do
  Then 'I should be on "the account editing page"'
  And 'I should see "Editar Cuenta"'
end

Then /^I should not see my account page$/ do
  Then 'I should not see "Mi Cuenta"'
end
