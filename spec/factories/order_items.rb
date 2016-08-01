FactoryGirl.define do
  factory :order_item do
    order
    ticket_type
    quantity { Faker::Number.between(1, 10) }
  end
end
