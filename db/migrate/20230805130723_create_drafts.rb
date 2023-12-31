class CreateDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :drafts do |t|
      t.integer :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :drafts, :user_id
  end
end
