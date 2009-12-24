class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.references :user
      t.string :language
      t.string :time_zone

      t.timestamps
    end

    User.all.each { |u| u.create_preference if u.preference.nil? }
  end

  def self.down
    drop_table :preferences
  end
end
