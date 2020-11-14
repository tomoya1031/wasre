FactoryBot.define do
    factory :comment do
        association :user
        association :product
        comment               {"テスト"}
    end
end