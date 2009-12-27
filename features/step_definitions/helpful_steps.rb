Entonces /^debug$/ do
  debugger
end

Cuando /^hago click en "(.+)"$/ do |nombre|
  click_button(nombre)
end

Entonces /^el usuario "([^\"]*)" estará asociado a la región "([^\"]*)"$/ do |nombre_usuario, nombre_region|
  User.find_by_name(nombre_usuario).region.should == Region.find_by_name(nombre_region)
end

Entonces /^estaré asociado a la región "([^\"]*)"$/ do |nombre_region|
  User.last.region.should == Region.find_by_name(nombre_region)
end

Entonces /^ver[eé] "([^\"]*)"$/ do |texto|
  response.should contain(texto)
end

Entonces /^veré que mi region es "([^\"]*)"$/ do |nombre|
  response.should have_tag("#user_region_name", nombre)
end


