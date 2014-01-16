class AddTagToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :tag_id, :integer
  end
end
