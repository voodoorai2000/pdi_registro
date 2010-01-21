Given /^I am a user who opened my reset password email$/ do
  Given "I am a confirmed user with email \"bob@example.com\""
  When "I go to the reset password page"
  And "I fill in \"email\" with \"bob@example.com\""
  And "I press \"Resetear mi contraseña\""
  Then "\"bob@example.com\" should receive an email"
  When "I open the email"
  Then "I should see \"resetear su contraseña\" in the email body"
end


Then /^I (?:should )?see a reset password form$/ do
  response.should contain('Olvidé mi contraseña')
  response.should contain('Email')
end

Then /^I (?:should )?see a password modification form$/ do
  response.should contain('Cambiar Mi Contraseña')
  response.should contain('Contraseña')
  response.should contain('Confirmacíon nueva contraseña')
end

Then /^I should not see a password modification form$/ do
  response.should_not contain('Cambiar Mi Contraseña')
end
