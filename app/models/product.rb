class Product < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :room
  belongs_to :genre, optional: true
  accepts_attachments_for :product_images, attachment: :image

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :introduction, presence: true, length: { minimum: 2, maximum: 300 }
  validates :genre_id, presence: true
  validates :status, presence: true

  enum status: {'新品・未使用': 0,'未使用に近い': 1,'目立った傷や汚れなし': 2,'やや傷や汚れあり': 3,'傷や汚れあり': 4,'全体的に状態が悪い': 5}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
