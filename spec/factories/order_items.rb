FactoryGirl.define do
 factory :order_items do
  quantity 1
  order
  product
  unit_price 3
  status "pending"
  package
 end
end
