class User < ApplicationRecord
  has_many :senryus, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationship, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationship, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :update, unless: Proc.new { |user| user.password.blank? }
  validates :bio, length: { maximum: 150 }

  mount_uploader :icon, IconUploader
end
