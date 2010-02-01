Dado /^las regiones "([^\"]*)"$/ do |nombres|
  split_and_strip(nombres).each do |nombre|
    Factory(:region, :name => nombre)
  end
end

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

Entonces /^veré que mis? (.+) (?:es|son) "([^\"]*)"$/ do |campo, valor|
  response.should have_tag("#user_#{campo.to_field}", valor)
end

Then /^vere las ([^\"]+) "([^\"]*)" en ese orden$/ do |modelo, nombres|
  model_name = modelo.to_model.name.underscore
  split_and_strip(nombres).each_with_index do |nombre, index|
    resource = modelo.to_model.find_by_name(nombre)
    response.body.should have_tag("##{model_name}_#{resource.id}:nth-child(#{index+1})")
  end
end

Entonces /^vere que "([^\"]*)" tiene (\d+) usuarios registrados$/ do |region, registros|
  region = Region.find_by_name(region)
  response.should have_tag("#region_#{region.id}_users", registros)
end

Entonces /^no vere la region "([^\"]*)"$/ do |name|
  region = Region.find_by_name(name)
  response.should_not have_tag("#region_#{region.id}")
end

