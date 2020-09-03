class ProductImag < ApplicationRecord

    has_many :products

    attachment :image
end
