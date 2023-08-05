class Saveforlater < ApplicationRecord
    belongs_to :articles, foreign_key: 'article_id', class_name: 'Article'
    belongs_to :users, foreign_key: 'user_id', class_name: 'User'
end
