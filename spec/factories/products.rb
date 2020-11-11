FactoryBot.define do
    factory :product do
      association :user
      genre_id         {"1"}
      name             {"ケーキ"}
      introduction     {"ケーキだよ"}
      status           {"新品・未使用"}
      is_active        {"ture"}
       product_images   { File.new("#{Rails.root}/app/assets/images/imge5.png") }
    end
  end