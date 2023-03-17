class AddCheckedToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :checked, :boolean, null: false, default: false
  end
end
