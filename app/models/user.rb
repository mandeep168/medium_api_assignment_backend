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
    has_one :profile, dependent: :destroy
end
