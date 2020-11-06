class Product < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :notifications, dependent: :destroy
  has_one :room
  belongs_to :user
  belongs_to :genre, optional: true
  accepts_attachments_for :product_images, attachment: :image
  accepts_nested_attributes_for :tags, allow_destroy: true

  validates :product_images_images, :presence => {:message => '最低一枚画像を投稿してください'}
  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :introduction, presence: true, length: { minimum: 1, maximum: 300 }
  validates :genre_id, presence: true
  validates :status, presence: true
  

  enum status: {'新品・未使用': 0,'未使用に近い': 1,'目立った傷や汚れなし': 2,'やや傷や汚れあり': 3,'傷や汚れあり': 4,'全体的に状態が悪い': 5}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name)unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_product_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_product_tag
    end
  end

end
