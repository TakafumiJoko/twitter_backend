class TweetRelationship < ApplicationRecord
  belongs_to :reply, class_name: "Tweet"
  belongs_to :replied, class_name: "Tweet"
end
