class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :low_resolution
      t.string :standard_resolution
      t.string :link
      t.string :thumbnail
      t.integer :location_id
      t.string :instagram_id

      t.timestamps
    end
  end
end
