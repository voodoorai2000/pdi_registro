Given /^"([^\"]*)" an invitation requested user$/ do |name|
  Given "\"#{name}\" is an anonymous user"
  When "I go to the invitation request form"
  And "I fill in \"Su nombre completo\" with \"#{name}\""
  And "I fill in \"Su email\" with \"#{name}@example.com\""
  And "I press \"¡Solicitar!\""
  Then "I should have a successful invitation"
end

Given /^"([^\"]*)" an invitation notified but unconfirmed user$/ do |name|
  Given "\"#{name}\" an invitation requested user"
  And "I logged in as an administrator"
  When "I go to the invitations list page"
  And "I invite \"#{name}@example.com\""
  Then "\"#{name}@example.com\" should receive 1 email"
  When "I follow \"Cerrar Sesión\""
  Then "I should be logged out"
  open_email("#{name}@example.com")
end

Then /^I should see the invitation request form$/ do
  response.should contain("Su nombre completo")
  response.should contain("Su email")
end

Then /^I should see the invitation signup form$/ do
  response.should contain("Nombre")
  response.should contain("Email")
  response.should contain("Usuario")
  response.should contain("Escriba su contraseña")
  response.should contain("Confirmación contraseña")
  response.should contain("Open ID")
end

Then /^I should have a successful invitation$/ do
  Then 'I should see "Gracias, le notificaremos cuando estemos preparados."'
end

Then /^I should have an unsuccessful invitation$/ do
  Then 'I should not see "Gracias, le notificaremos cuando estemos preparados."'
end

Then /^I should see "([^\"]*)" can be invited$/ do |mail|
  response.should contain("#{mail}")
end

When /^I invite "([^\"]*)"$/ do |name|
  click_link('Enviar email a los invitados')
end

