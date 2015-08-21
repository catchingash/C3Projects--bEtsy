FactoryGirl.define do
 factory :order_items do
  quantity 1
  order_id 1
  product_id 1
  unit_price 3
  total_price 3
  status "pending"
  package_id 1
 end
end
