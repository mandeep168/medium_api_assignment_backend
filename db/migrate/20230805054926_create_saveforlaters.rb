class CreateSaveforlaters < ActiveRecord::Migration[7.0]
  def change
    create_table :saveforlaters do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
    add_index :saveforlaters, :user_id
    add_index :saveforlaters, :article_id
  end
end
