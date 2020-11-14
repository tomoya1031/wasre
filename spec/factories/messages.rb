FactoryBot.define do
    factory :message do
        association :user
        association :room
        message               {"テスト"}
    end
end