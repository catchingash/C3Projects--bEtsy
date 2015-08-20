FactoryGirl.define do
  factory :package do
    weight 1.500
    length 10.000
    width 5.500
    height 15.500
    cost 1
    service "MyString"
    user_id 1
    buyer_id 1
  end
end
