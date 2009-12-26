class CreateOrchards < ActiveRecord::Migration
  def self.up
    create_table :orchards do |t|
      t.string :name
      t.integer :area
      t.string :longitude
      t.string :latitude
      t.boolean :used

      t.timestamps
    end
  end

  def self.down
    drop_table :orchards
  end
end
