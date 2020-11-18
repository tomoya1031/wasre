FactoryBot.define do
    factory :comment do
        association :user
        association :product
        comment               {"テストコメント１"}
    end
end