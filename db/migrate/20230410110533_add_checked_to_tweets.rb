class AddCheckedToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :checked, :boolean, default: false, null: false
  end
end
