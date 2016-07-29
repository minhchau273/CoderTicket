FactoryGirl.define do
  factory :ticket_type do
    name { Faker::Name.name }
    price { Faker::Number.decimal(2) }
    max_quantity { Faker::Number.between(1, 1000) }
    event
  end
end
