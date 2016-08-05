FactoryGirl.define do
  factory :ticket_type do
    name { Faker::Name.name }
    price { Faker::Number.number(8) }
    max_quantity { Faker::Number.between(10, 1000) }
    event
  end
end
