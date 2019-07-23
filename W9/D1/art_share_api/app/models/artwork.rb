# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :text             not null
#  image_url  :text
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
    validates_uniqueness_of :title, :scope => :artist_id

    belongs_to :artist,
        class_name: 'User',
        primary_key: :id,
        foreign_key: :artist_id

    has_many :artwork_shares,
        class_name: :ArtworkShare,
        primary_key: :id,
        foreign_key: :artwork_id

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    has_many :comments,
        class_name: 'Comment',
        primary_key: :id,
        foreign_key: :artwork_id
end
