Dado /^las regiones "([^\"]*)"$/ do |nombres|
  split_and_strip(nombres).each do |nombre|
    Factory(:region, :name => nombre)
  end
end

Dado /^no hago nada mas$/ do
  puts "nothing for nothing gives nothing"
end

Entonces /^debug$/ do
  debugger
end

Cuando /^hago click en "(.+)"$/ do |nombre|
  click_button(nombre)
end

Cuando /^al lado del usuario "([^\"]*)" hago click en el link "([^\"]*)"$/ do |nombre, link|
  user = User.find_by_name(nombre)
  click_link_within("#user_#{user.id}", link)
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

Entonces /el checkbox "([^\"]*)" estará marcado$/ do |label|
  field_labeled(label).should be_checked
end

Then /^vere las ([^\"]+) "([^\"]*)" en ese orden$/ do |modelo, nombres|
  model_name = modelo.to_model.name.underscore
  split_and_strip(nombres).each_with_index do |nombre, index|
    resource = modelo.to_model.find_by_name(nombre)
    response.body.should have_tag("##{model_name}_#{resource.id}:nth-child(#{index+2})")
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

Entonces /^el usuario "([^\"]*)" no estará en la base de datos$/ do |nombre|
  User.find_by_name(nombre).should be_nil
end

Entonces /^veré que (?:mi|mis) (.*) (?:es|son) "([^\"]*)"$/ do |attribute, value|
  response.should have_tag("#user_#{attribute.to_field}", value)
end


