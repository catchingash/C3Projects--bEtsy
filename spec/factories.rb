FactoryGirl.define do

  factory :shipping do
    carrier "ups"
    service_name "Next Day Air"
    price 12345
    order_id 1
  end

  factory :order do
    buyer_name "Panda"
    buyer_email "panda@panda.com"
    buyer_card_short "3920"
    buyer_street "123 Knockturn Alley"
    buyer_city "Seattle"
    buyer_state "WA"
    buyer_zip "98115"
  end

  factory :order_item do
    product_id 1
    order_id 1
    quantity_ordered 5
  end

  factory :product do
    name "Widget"
    price "1_000_000"
    seller_id "1"
    stock 6
    description "It widgets."
    weight 4
    length 6
    width 2
    height 8
  end
end
