# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  user_id    :text             not null
#  artwork_id :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord

    belongs_to :user,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :artwork,
        class_name: :Artwork,
        primary_key: :id,
        foreign_key: :artwork_id
    
end
