class CreateTweetRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :tweet_relationships do |t|
      t.references :reply, null: false, foreign_key: { to_table: :tweets }
      t.references :replied, null: false, foreign_key: { to_table: :tweets }

      t.timestamps
    end
  end
end
