class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.text :title, null: false
      t.text :image_url
      t.integer :artist_id, null: false

      t.timestamps
    end
  end

end
