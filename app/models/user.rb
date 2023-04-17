class User < ApplicationRecord
  before_validation :set_name, on: :create

  has_many :tweets, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :following

  
  validates :name, presence: true, length: { in: 5..15 }, uniqueness: true, format: { with: /\A@[\w_]+\z/ }
  validates :nickname, presence: true, length: { in: 4..50 }
  validates :phone_number, uniqueness: true, format: { with: /\A0\d{9,10}\z/ }, allow_nil: true
  validates :email, length: { maximum: 256 }, format: { with: /\A[\w.+_\-]+@(\w([\w-]*\w).){1,3}[a-z]{2,}\z/ }, allow_nil: true
  validates :birthday, presence: true
  validates :password, presence: true, length: { in: 6..16 }, format: { with: /\A[\w_@!?]+\z/ }
  validates :introduction, length: { maximum: 160 }, on: :update
  validates :residence, length: { maximum: 30 }, on: :update
  validates :website, length: { maximum: 100 }, uniqueness: { case_sensitive: false }, format: { with: /\Ahttps?:\/\/(\w([\w-]*\w).){1,3}[a-z]{2,}(\/[\w_\-]*)*\z/ }, allow_nil: true, on: :update
    
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.includ?(user)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["birthday", "created_at", "email", "id", "introduction", "name", "nickname", "password", "phone_number", "residence", "updated_at", "website"]
  end

  private
    def set_name
      self.name = "@" + SecureRandom.alphanumeric(14)
    end
end
