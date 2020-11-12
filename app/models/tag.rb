class Tag < ApplicationRecord

  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :products, through: :tag_maps

  validates :tag_name, presence: true, length: { minimum: 1, maximum: 15 }
end