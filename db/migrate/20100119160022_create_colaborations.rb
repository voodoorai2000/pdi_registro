class CreateColaborations < ActiveRecord::Migration
  def self.up
    create_table :colaborations do |t|
      t.integer :user_id
      t.integer :area_id

      t.timestamps
    end
  end

  def self.down
    drop_table :colaborations
  end
end
