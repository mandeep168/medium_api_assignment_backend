class AddEstimatedtimeToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :estimatedtime, :integer
  end
end
