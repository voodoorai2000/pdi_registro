class CreateRootUser < ActiveRecord::Migration
  def self.up
    create_user_by_login("root", ["admin"])
  end

  def self.down
    delete_user_by_login("root")
  end

  def self.create_user_by_login(login, roles=[])
    unless User.find_by_login(login)
      puts "Creating user '#{login}' ..."
      u = User.new
      u.signup!({:name => login, :email => "#{login}@example.com"}, false)
      u.activate!({:login => login, :password => login, :password_confirmation => login}, false)
      roles.each do |r|
        u.roles << Role.find_by_name(r.to_s)
      end
      puts "user '#{login}' created. login/password is #{login}/#{login}."
    else
      puts "user '#{login}' already exists."
    end
  end

  def self.delete_user_by_login(login)
    if u = User.find_by_login(login)
      u.delete
      puts "user '#{login}' deleted."
    end
  end
end
