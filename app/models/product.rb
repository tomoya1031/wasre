class Product < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :product_imags, dependent: :destroy
  belongs_to :genre, optional: true
  

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
