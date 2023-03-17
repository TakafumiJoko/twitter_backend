class AddCountToTrends < ActiveRecord::Migration[7.0]
  def change
    add_column :trends, :count, :integer
    add_index :trends, :count
    change_column_null :trends, :count, false
  end
end
