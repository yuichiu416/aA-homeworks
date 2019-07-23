class CreateArtwork < ActiveRecord::Migration[5.2]
  def change
    validates :title, presence: true, uniqueness: true
    validates :image_url, presence: true
    validates :artist_id, presence: true


    create_table :artworks do |t|

    end
  end
end
