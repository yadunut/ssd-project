class AddUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false, default: '', unique: true
    add_index :users, :username
  end
end
