class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :product

  validates :comment, presence: true, length: { minimum: 1, maximum: 300 }

end
