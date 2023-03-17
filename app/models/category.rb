class Category < ApplicationRecord
  has_many :trends

  validates :name, presence: true, length: { in: 1..15 }, uniqueness: true    
end
