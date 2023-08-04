class AddProfilesAssociationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :profile, :user_id, :integer 
    add_index 'profile', ['user_id'], :name => 'profile_user_index_user_id'
  end
end
