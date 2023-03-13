class AddPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password, :string
    add_index :users, :password
    change_column_null :users, :password, false
  end
end