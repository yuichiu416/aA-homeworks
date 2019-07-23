# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ActiveRecord::Base.transaction do
    User.destroy_all
    Artwork.destroy_all
    ArtworkShare.destroy_all
    
# user - username
# artwork - title, image_url, artist_id
# artwork_share - artwork_id, viewer_id
user1 = User.create!(username: 'user1234')
user2 = User.create!(username: 'user567')
user3 = User.create!(username: 'user890')

artwork1 = Artwork.create!(title: 'Mona Lisa', image_url: 'https://bit.ly/1EA3xHu', artist_id: user1.id)
artwork2 = Artwork.create!(title: 'Skrik', image_url: 'https://bit.ly/1Sy8lrz', artist_id: user2.id)
artwork3 = Artwork.create!(title: 'The Gleaners', image_url: 'https://bit.ly/2gvTTDt', artist_id: user3.id)
artwork4 = Artwork.create!(title: 'The Last Supper', image_url: 'https://bit.ly/2Z8gBFj', artist_id: user1.id)


ArtworkShare.create!(artwork_id: artwork1.id, viewer_id: user1.id)
ArtworkShare.create!(artwork_id: artwork2.id, viewer_id: user2.id)
ArtworkShare.create!(artwork_id: artwork3.id, viewer_id: user3.id)
ArtworkShare.create!(artwork_id: artwork4.id, viewer_id: user1.id)

end