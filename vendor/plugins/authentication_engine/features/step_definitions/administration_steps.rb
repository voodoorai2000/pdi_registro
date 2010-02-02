Given /^"(.*)" an admin user$/ do |name|
  #Given "I am a confirmed user \"#{name}\" with password \"secret\""
  u = User.new
  u.signup!({:name => name, :email => "#{name}@example.com"}, false) {}
  u.activate!({:login => name, :password => "secret", :password_confirmation => "secret"}, false) {}
  u.roles << Role.find_or_create_by_name('admin')
end

Given /^admin should receive an email$/ do
  Then "\"admin@example.com\" should receive 1 email"
end

When /^I logged in as an administrator$/ do
  Given "I am logged in as \"sharon\" with password \"secret\""
end

When /^admin open the email$/ do
  open_email("admin@example.com")
end

Then /^admin should see "([^\"]*)" in the email$/ do |text|
  Then "\"admin@example.com\" opens the email with text \"#{text}\""
end

Then /^I should see the admin root page$/ do
  response.should contain('Usuarios')
  response.should contain('Invitaciónes')
  response.should contain('Areas')
end