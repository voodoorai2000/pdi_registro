Dado /^"([^\"]*)" una usuaria activada con email "([^\"]*)"$/ do |name, email|
  user_attributes = {:login => name, :email => email, :password => "secret", :password_confirmation => "secret"}
  u = User.new(user_attributes)
  u.signup!(user_attributes, false) {}
  u.activate!({:login => name, :password => "secret", :password_confirmation => "secret"}, false) {}
end

Dado /^"([^\"]*)" un usuario registrado pero no activado con email "([^\"]*)"$/ do |name, email|
  user_attributes = {:login => name, :email => email, :password => "secret", :password_confirmation => "secret"}
  u = User.new(user_attributes)
  u.signup!(user_attributes, false) {}
  u.should_not be_active
  User.not_active.should_not be_empty
end
