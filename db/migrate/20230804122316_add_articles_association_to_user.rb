class AddArticlesAssociationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :user_id, :integer 
    add_index 'articles', ['user_id'], :name => 'index_user_id'
  end
end
