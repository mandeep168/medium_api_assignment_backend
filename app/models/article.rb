class Article < ApplicationRecord
    belongs_to :user
    belongs_to :topic
    has_many :likes, class_name: 'Like', dependent: :destroy
    has_many :views, class_name: 'View', dependent: :destroy
    has_many :comments, class_name: 'Comment', dependent: :destroy
    has_many :userlists, class_name: 'Userlist', dependent: :destroy
    has_many :saveforlaters, class_name: 'Saveforlater', dependent: :destroy
    has_one_attached :image
end
