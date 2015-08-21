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

end
