Entonces /^debug$/ do
  debugger
end

Cuando /^hago click en "(.+)"$/ do |value|
  click_button(value)
end

Entonces /^el usuario "([^\"]*)" estará asociado a la región "([^\"]*)"$/ do |nombre_usuario, nombre_region|
  User.find_by_name(nombre_usuario).region.should == Region.find_by_name(nombre_region)
end