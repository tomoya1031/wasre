class ProductImage < ApplicationRecord

    belongs_to :product
    attachment :image

end
