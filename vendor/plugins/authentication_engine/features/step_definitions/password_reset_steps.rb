Given /^I am a user who opened my reset password email$/ do
  Given "I am a confirmed user with email \"bob@example.com\""
  When "I go to the reset password page"
  And "I fill in \"email\" with \"bob@example.com\""
  And "I press \"Reset my password\""
  Then "\"bob@example.com\" should receive an email"
  When "I open the email"
  Then "I should see \"reset your password\" in the email body"
end


Then /^I (?:should )?see a reset password form$/ do
  response.should contain('Forgot Password')
  response.should contain('Email')
end

Then /^I (?:should )?see a password modification form$/ do
  response.should contain('Change My Password')
  response.should contain('Password')
  response.should contain('Password confirmation')
end

Then /^I should not see a password modification form$/ do
  response.should_not contain('Change My Password')
end
