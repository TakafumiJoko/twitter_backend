class AddImagesToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :images, :json
  end
end
