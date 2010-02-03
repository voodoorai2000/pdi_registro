class UserMoreInfor < ActiveRecord::Migration
  def self.up
    add_column :users, :more_info, :text
  end

  def self.down
    remove_column :users, :more_info
  end
end
