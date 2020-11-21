FactoryBot.define do
    factory :product_image do
        association :product
        image_id    {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/picture.jpg"))  }
    end
end