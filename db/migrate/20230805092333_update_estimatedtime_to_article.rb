class UpdateEstimatedtimeToArticle < ActiveRecord::Migration[7.0]
  def change
    change_column :Articles, :estimatedtime, :string
  end
end
