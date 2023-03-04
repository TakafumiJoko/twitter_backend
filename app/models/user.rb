class User < ApplicationRecord
  before_validation :set_name, on: :create

  has_many :tweets, dependent: :destroy

  validates :name, presence: true, length: { in: 5..15 }, uniqueness: true, format: { with: /\A@[\w_]+\z/ }
  validates :nickname, presence: true, length: { in: 4..50 }
  validates :phone_number, length: { in: 10..11 }, uniqueness: true, format: { with: /\A0\d+\z/ }, allow_nil: true
  validates :email, length: { maximum: 256 }, format: { with: /\A[\w.+_\-]+@(\w([\w-]*\w).){1,3}[a-z]{2,}\z/ }, allow_nil: true
  validates :birthday, presence: true
  validates :introduction, length: { maximum: 160 }, on: :update
  validates :residence, length: { maximum: 30 }, on: :update
  validates :website, length: { maximum: 100 }, uniqueness: { case_sensitive: false }, format: { with: /\Ahttps?:\/\/(\w([\w-]*\w).){1,3}[a-z]{2,}(\/[\w_\-]*)*\z/ }, allow_nil: true, on: :update
    
  def set_name
    self.name = "@" + SecureRandom.alphanumeric(14)
  end
end
