class Article < ApplicationRecord
    belongs_to :user
    belongs_to :topic
    has_many :likes, class_name: 'Like', dependent: :destroy
    has_many :comments, class_name: 'Comment', dependent: :destroy
end
