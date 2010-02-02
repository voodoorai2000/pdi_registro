Given /^I am an anonymous user$/ do
  visit '/logout'
end

Given /^I am a confirmed user "([^\"]*)" with password "([^\"]*)"$/ do |name, password|
  u = User.new
  u.signup!({:name => name, :email => "#{name}@example.com"}, false) {}
  u.activate!({:login => name, :password => password, :password_confirmation => password}, false) {}
end

Given /^I am a confirmed user with email "([^\"]*)"$/ do |email|
  u = User.new
  u.signup!({:name => "Foo Bar", :email => email}, false) {}
  u.activate!({:login => 'foobar', :password => 'secret', :password_confirmation => 'secret'}, false) {}
end

Given /^I am an un-confirmed user with email "([^\"]*)"$/ do |email|
  u = User.new
  u.signup!({:name => "Foo Bar", :email => email}, false) {}
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |login, password|
  unless login.blank?
    visit login_path
    fill_in "Usuario", :with => login
    fill_in "Contraseña", :with => password
    click_button "Entrar"
    # save_and_open_page 
  end
end

Given /^I am logged in as "([^\"]*)" with email "([^\"]*)"$/ do |name, email|
  u = User.new
  u.signup!({:name => name, :email => email}, false) {}
  u.activate!({:login => name, :password => 'secret', :password_confirmation => 'secret'}, false) {}
  visit login_path
  fill_in "Usuario", :with => name
  fill_in "Contraseña", :with => 'secret'
  click_button "Identifíquese"
  save_and_open_page 
end

Given /^I should see a login form$/ do
  response.should contain("Usuario")
  response.should contain("Contraseña")
  response.should contain("Recordarme")
  response.should contain("Open ID")
end

When /^I open the homepage in a new window with cookies$/ do
  in_a_separate_session do |sess|
    visit root_path
    response.should contain("Cerrar Sesión")
  end
  response.should contain("Cerrar Sesión")
end

When /^I open the homepage in a new window without cookies$/ do
  in_a_new_session do |sess|
    visit root_path
    response.should_not contain("Cerrar Sesión")
  end
  response.should contain("Cerrar Sesión")
end

# http://wiki.github.com/aslakhellesoy/cucumber/multiline-step-arguments
# http://wiki.github.com/aslakhellesoy/cucumber/background
Given /^the following user records$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    # ex: hash = {'login' => 'bob', 'password' => 'secret'}
    u = User.new
    u.signup!({:name => hash['login'], :email => "#{hash['login']}@example.com"}, false) {}
    u.activate!({:login => hash['login'], :password => hash['password'], :password_confirmation => hash['password']}, false) {}
  end
end

Factory.define :user do |f|
  f.sequence(:name) { |n| "name#{n}" }
  f.sequence(:login) { |n| "foo#{n}" }
  f.password "foobar"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end
