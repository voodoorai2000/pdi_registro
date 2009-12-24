Given /^"([^\"]*)" an invitation requested user$/ do |name|
  Given "\"#{name}\" is an anonymous user"
  When "I go to the invitation request form"
  And "I fill in \"Applicant's full name\" with \"#{name}\""
  And "I fill in \"Applicant's email address\" with \"#{name}@example.com\""
  And "I press \"Request\""
  Then "I should have a successful invitation"
end

Given /^"([^\"]*)" an invitation notified but unconfirmed user$/ do |name|
  Given "\"#{name}\" an invitation requested user"
  And "I logged in as an administrator"
  When "I go to the invitations list page"
  And "I invite \"#{name}@example.com\""
  Then "\"#{name}@example.com\" should receive 1 email"
  When "I follow \"Logout\""
  Then "I should be logged out"
  open_email("#{name}@example.com")
end

Then /^I should see the invitation request form$/ do
  response.should contain("Applicant's full name")
  response.should contain("Applicant's email address")
end

Then /^I should see the invitation signup form$/ do
  response.should contain("Name")
  response.should contain("Email")
  response.should contain("Login")
  response.should contain("Password")
  response.should contain("Password confirmation")
  response.should contain("Open ID")
end

Then /^I should have a successful invitation$/ do
  Then 'I should see "Thank you, we will notify you when we are ready."'
end

Then /^I should have an unsuccessful invitation$/ do
  Then 'I should not see "Thank you, we will notify you when we are ready."'
end

Then /^I should see "([^\"]*)" can be invited$/ do |mail|
  response.should contain("#{mail}")
end

When /^I invite "([^\"]*)"$/ do |name|
  click_link('Send mail to invitee')
end

