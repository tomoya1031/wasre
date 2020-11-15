FactoryBot.define do
    factory :product do
      association :user
      genre_id         {1}
      name             {"ケーキ"}
      introduction     {"ケーキだよ"}
      status           {"新品・未使用"}
      is_active        {"false"}
      #product_image   { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    end
end