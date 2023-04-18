class RemovePopularityFromTrends < ActiveRecord::Migration[7.0]
  def change
    remove_column :trends, :popularity, :integer
  end
end
