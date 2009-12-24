class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name, :null => false
      t.string :title
      t.string :description

      t.timestamps
    end

    create_table :roles_users, :id => false do |t|
      t.references :user, :null => false
      t.references :role, :null => false
    end

    Role.find_or_create_by_name(:name => 'member', :title => 'Member')
    Role.find_or_create_by_name(:name => 'author', :title => 'Author')
    Role.find_or_create_by_name(:name => 'manager', :title => 'Manager')
    Role.find_or_create_by_name(:name => 'admin', :title => 'Administrator')
    puts "Roles (member, author, manager, admin) created."
  end

  def self.down
    drop_table :roles_users
    drop_table :roles
  end
end
