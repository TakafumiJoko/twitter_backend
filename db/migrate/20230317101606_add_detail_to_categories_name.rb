class AddDetailToCategoriesName < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :name
    change_column_null :categories, :name, false
  end
end
