class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :post_code, presence: true, length: { is: 7 }
  validates :prefecture_name, presence: true
  validates :address_city, presence: true, length: {minimum: 2,maximum: 50}
  validates :address_street , presence: true, length: {minimum: 1,maximum: 50}
  validates :phone_number, presence: true, length: {minimum: 3,maximum: 15}

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :orders, dependent: :destroy

  attachment :profile_image

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
