FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    email { "#{name}@email.com" }
    password "fr@nklin"
    password_confirmation "fr@nklin"
    address "address"
    city "Seattle"
    state "WA"
    zip "98101"
  end
end
