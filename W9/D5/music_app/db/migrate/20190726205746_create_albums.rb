class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :name, null: false
      t.integer :year, null: false
      t.boolean :live, default: false, null: false
      
    end
    add_index :albums, %i(band_id name), unique: true
  end
end
