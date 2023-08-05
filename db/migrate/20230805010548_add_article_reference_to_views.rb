class AddArticleReferenceToViews < ActiveRecord::Migration[7.0]
  def change
    add_reference :views, :article, null: false, foreign_key: true
  end
end
