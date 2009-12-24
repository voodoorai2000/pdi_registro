Given /^I have not sent any invites before$/ do
  pending
end

Then /^I should see invitation form$/ do
  response.should contain("New Invitation")
  response.should contain("Friend's full name")
  response.should contain("Friend's email address")
end

Then /^I should have (\d+) invitations left$/ do |amount|
  response. should contain("(#{amount} left)") 
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
  When "I follow \"Send Invitation\""
  And "I fill in \"Friend's full name\" with \"#{invitee.split('@').first}\""
    And "I fill in \"Friend's email address\" with \"#{invitee}\""
    And "I press \"Invite!\""
  Then "I should see \"Thank you, invitation sent.\""
  When "I follow \"Logout\""
  Then "I should be logged out"
end
