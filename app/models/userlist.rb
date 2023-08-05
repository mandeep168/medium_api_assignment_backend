class Userlist < ApplicationRecord
    belongs_to :articles, foreign_key: 'article_id', class_name: 'Article'
    belongs_to :lists, foreign_key: 'list_id', class_name: 'List'
end
