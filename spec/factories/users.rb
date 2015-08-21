FactoryGirl.define do
  factory :user do
    name "Frank"
    email "name@email.com"
    password "fr@nklin"
    password_confirmation "fr@nklin"
    address "1234 Cherry Lane"
    city "Seattle"
    state "WA"
    zip 98112
  end
end
