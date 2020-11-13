FactoryBot.define do
    factory :user do
      name                  {"toda"}
      post_code             {"6240942"}
      prefecture_code       {"26"}
      address_city          {"舞鶴市"}
      address_street        {"青井"}
      phone_number          {"000000000"}
      sequence(:email) { |n| "TEST#{n}@example.com"}
      password              {"12345678"}
      password_confirmation {"12345678"}
    end
end