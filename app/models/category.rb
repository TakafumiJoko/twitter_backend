class Category < ApplicationRecord
  has_many :hash_tags

  validates :name, presence: true, length: { in: 1..15 }, uniqueness: true    
end
