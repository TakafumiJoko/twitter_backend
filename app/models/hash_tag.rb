class HashTag < ApplicationRecord
  belongs_to :category
  belongs_to :tweet
end
