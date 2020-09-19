class ProductImage < ApplicationRecord

    belongs_to :product
    attachment :image

    validates :image, presence: true
end
