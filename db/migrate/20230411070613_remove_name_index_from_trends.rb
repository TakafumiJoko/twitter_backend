class RemoveNameIndexFromTrends < ActiveRecord::Migration[7.0]
  def change
    remove_index :trends, :name
  end
end
