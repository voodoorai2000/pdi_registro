Given /"([^\"]*)" is an anonymous user/ do |name|
  visit '/logout'
end

Given /^I have registered successfully$/ do
  Given "I am an anonymous user"
  When "I go to the registration form"
  And "I fill in \"name\" with \"bob\""
  And "I fill in \"email\" with \"bob@example.com\""
  And "I press \"Register\""
  Then "I should have a successful registration"
end

Given /^I have received an activation email$/ do
  Given "\"bob@example.com\" should receive an email"
  When "I open the email"
  Then "I should see \"activate your account\" in the email body"
end

Given /^I have successfully activated my account$/ do
  Given "I have registered successfully"
    And "I have received an activation email"
    And "I follow \"activate your account\" in the email"
  Then "I should see the activation form"
  And "I fill in \"login\" with \"bob\""
  And "I fill in \"set your password\" with \"secret\""
  And "I fill in \"password confirmation\" with \"secret\""
  And "I press \"Activate\""
  Then "I should have a successful activation"
  And "I should be logged in"
end

Then /^I should see the registration form$/ do
  response.should contain('Name')
  response.should contain('Email')
end

Then /^I should see the activation form$/ do
  response.should contain('Name') if controller.params[:invitation_token]
  response.should contain('Email') if controller.params[:invitation_token]
  response.should contain('Login')
  response.should contain('Set your password')
  response.should contain('Password confirmation')
  response.should contain('Open ID')
end

Then /^I should have (an|\d*) errors?$/ do |amount|
  amount = 1 if amount == "an"
  response.should contain("#{amount} error")
end

Then /^I should have a successful registration$/ do
  Then 'I should see "Your account has been created"'
end

Then /^I should have an unsuccessful registration$/ do
  Then 'I should not see "Your account has been created"'
end

Then /^I should have a successful activation$/ do
  Then "I should see my account editing page"
  And 'I should see "Your account has been activated"'
end

Then /^I should have an unsuccessful activation$/ do
  Then 'I should not see "Your account has been activated"'
end

Then /^I should be logged in$/ do
  Then 'I should see "My Account"'
end

Then /^I should not be logged in$/ do
  Then 'I should not see "My Account"'
end

Then /^I should be logged out$/ do
  Then 'I should not be logged in'
  And 'I should see "Logout successful!"'
end

Then /^I should see the home page$/ do
  Then 'I should see "Home"'
end

Then /^I should see my account page$/ do
  Then 'I should be on "the account page"'
  And 'I should see "User Account"'
end

Then /^I should see my account editing page$/ do
  Then 'I should be on "the account editing page"'
  And 'I should see "Editing My Account"'
end

Then /^I should not see my account page$/ do
  Then 'I should not see "User Account"'
end
