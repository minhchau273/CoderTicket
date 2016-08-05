FactoryGirl.define do
  factory :order_item do
    order
    ticket_type
    quantity { Faker::Number.between(1, MAX_QUANTITY) }
  end
end
