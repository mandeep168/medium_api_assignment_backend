class CreateUserlists < ActiveRecord::Migration[7.0]
  def change
    create_table :userlists do |t|
      t.integer :list_id
      t.integer :article_id

      t.timestamps
    end
    add_index :userlists, :list_id
    add_index :userlists, :article_id
  end
end
