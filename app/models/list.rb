class List < ApplicationRecord
    belongs_to :users, foreign_key: 'user_id', class_name: 'User'
    has_many :userlists, class_name: 'UserList', dependent: :destroy
end
