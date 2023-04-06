class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweet_relationships, class_name: "TweetRelationship", foreign_key: "reply_id", dependent: :destroy
  has_many :reverse_of_tweet_relationships, class_name: "TweetRelationship", foreign_key: "replied_id", dependent: :destroy
  has_many :replyings, through: :tweet_relationships
  has_many :replies, through: :reverse_of_tweet_relationships
  has_many :hash_tags, dependent: :destroy

  validates :message, presence: true, length: { maximum: 140 }
end
