class Trend < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :count, presence: true, length: { maximum: 100 }, numericality: { only_integer: true }
  validates :popularity, presence: true, length: { maximum: 15 }, uniqueness: true, numericality: { only_integer: true }
end
