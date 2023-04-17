class AddCategoryRefToHashTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :hash_tags, :category, null: false, foreign_key: true
  end
end
