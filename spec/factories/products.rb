FactoryGirl.define do
  factory :product do
    name "box"
    price 3
    stock 1
    weight 1.500
    length 10.000
    width 5.500
    height 15.500
    user
  end
end
