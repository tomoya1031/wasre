class Genre < ApplicationRecord

  has_many :products

  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
end
