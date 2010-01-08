class AddMoreFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string
    add_column :users, :age, :string
    add_column :users, :gender, :string
  end

  def self.down
    remove_column :users, :gender
    remove_column :users, :age
    remove_column :users, :last_name
  end
end
