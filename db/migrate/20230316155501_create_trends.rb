class CreateTrends < ActiveRecord::Migration[7.0]
  def change
    create_table :trends do |t|
      t.string :name, null: false, index: true
      t.integer :popularity, null: false, index: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

