class Comment < ApplicationRecord
  validates :comment, presence :true

  belongs_to :user
  belongs_to :product
end
