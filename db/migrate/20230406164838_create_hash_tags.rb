class CreateHashTags < ActiveRecord::Migration[7.0]
  def change
    create_table :hash_tags do |t|
      t.string :value
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
