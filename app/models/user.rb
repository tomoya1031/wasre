class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]
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
  has_many :sns

  attachment :profile_image

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
  def self.from_omniauth(auth)       # snsから取得した、providerとuidを使って、既存ユーザーを検索
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create  # sns認証したことがあればアソシエーションで取得、なければSns_credentialsテーブルにレコード作成
  
    # snsのuser or usersテーブルに対し、SNS認証で取得したメールアドレスが登録済みの場合は、取得 or なければビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
      email: auth.info.email
    )
    if user.persisted?   # userが登録済みの場合：そのままログインするため、snsのuser_idを更新しとく
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }   # user、snsをハッシュで返す(コントローラーがこれを受け取る)
  end
end
