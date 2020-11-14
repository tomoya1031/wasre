FactoryBot.define do
    factory :tag_map do
        association :product
        association :tag
    end
end