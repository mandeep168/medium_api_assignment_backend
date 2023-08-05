class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

    has_many :articles, dependent: :destroy
    has_many :likes, class_name: 'Like', dependent: :destroy
    has_many :comments, class_name: 'Comment', dependent: :destroy
    has_many :views, class_name: 'View', dependent: :destroy
    has_one :profile, dependent: :destroy

    has_many :follows

    has_many :follower_relationships, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followers, through: :follower_relationships, source: :follower 

    has_many :following_relationships, foreign_key: :following_id, class_name: 'Follow'
    has_many :following, through: :following_relationships, source: :following 


end
