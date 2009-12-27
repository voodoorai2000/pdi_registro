Dado /^que estoy logado como "(.*)"$/ do |nombre|
    user = Factory.build(:user, :name => nombre)
    user.signup!({:name => user.name, :email => user.email}, false) {}
    user.activate!({:login => user.name, :password => 'secret', :password_confirmation => 'secret'}, false) {}
    visit login_path
    fill_in "Login", :with => user.login
    fill_in "Password", :with => 'secret'
    click_button "Login"
end