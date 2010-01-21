Given /^I have not sent any invites before$/ do
  pending
end

Then /^I should see invitation form$/ do
  response.should contain("Nueva Invitación")
  response.should contain("El nombre de la persona")
  response.should contain("El email de la persona")
end

Then /^I should have (\d+) invitations left$/ do |amount|
  response. should contain("(#{amount} restantes)") 
end

Given /^I am an invited user "([^\"]*)"$/ do |name|
  i = Invitation.create(:recipient_name => name, :recipient_email => "#{name}@example.com")
end

Given /^I am an invited user with email "([^\"]*)"$/ do |email|
  u = User.new
  u.signup_without_credentials!({:name => "Foo Bar", :email => email }) {}
  u.activate!({:login => 'foobar', :password => 'secret', :password_confirmation => 'secret'}, false) {}
end

Given /^I am a user with email "([^\"]*)" who was invited by "([^\"]*)"$/ do |invitee, inviter|
  Given "I am a confirmed user \"#{inviter}\" with password \"secret\""
    And "I am logged in as \"#{inviter}\" with password \"secret\""
  When "I follow \"Enviar Invitación\""
  And "I fill in \"El nombre de la persona\" with \"#{invitee.split('@').first}\""
    And "I fill in \"El email de la persona\" with \"#{invitee}\""
    And "I press \"¡Invita!\""
  Then "I should see \"Gracias, invitacion enviada.\""
  When "I follow \"Cerrar Sesión\""
  Then "I should be logged out"
end
