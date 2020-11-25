FactoryBot.define do
    factory :product_image do
        association :product
        image    {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/picture.jpg"))  }
    end
end