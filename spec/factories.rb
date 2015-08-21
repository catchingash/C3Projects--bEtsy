FactoryGirl.define do

  factory :shipping do
    carrier "ups"
    service_name "Next Day Air"
    price 12345
    order_id 1
  end
end
