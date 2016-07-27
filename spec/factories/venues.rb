FactoryGirl.define do
  factory :venue do
    name { Faker::Name.name }
    full_address { Faker::Address.street_address }
    region { Region.first }
  end
end
