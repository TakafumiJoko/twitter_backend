class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nickname, null: false
      t.string :phone_number
      t.string :email
      t.date :birthday, null: false
      t.text :introduction
      t.string :residence
      t.string :website

      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :nickname
    add_index :users, :phone_number, unique: true
    add_index :users, :email, unique: true
    add_index :users, :website, unique: true
  end
end
