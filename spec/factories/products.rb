FactoryBot.define do
    factory :product do
      genre_id         {"1"}
      name             {"ケーキ"}
      introduction     {"ケーキだよ"}
      status           {"新品・未使用"}
      is_active        {"ture"}
    end
  end