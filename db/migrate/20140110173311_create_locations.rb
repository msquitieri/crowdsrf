class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.string :foursquare_id
      t.string :name

      t.timestamps
    end
  end
end
