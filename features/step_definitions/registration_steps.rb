Dado /^"([^\"]*)" una usuaria activada con email "([^\"]*)"$/ do |name, email|
  u = User.new
  u.signup!({:name => name, :email => email}, false) {}
  u.activate!({:login => name, :password => "secret", :password_confirmation => "secret"}, false) {}
end

Dado /^"([^\"]*)" un usuario registrado pero no activado con email "([^\"]*)"$/ do |name, email|
  u = User.new
  u.signup!({:name => name, :email => email}, false) {}
  u.should_not be_active
  User.not_active.should_not be_empty
end
