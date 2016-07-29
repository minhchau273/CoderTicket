FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    starts_at { Time.current }
    ends_at { Time.current + 2.hours }
    hero_image_url { Faker::Avatar.image }
    extended_html_description "<h1>Test</h1>"
    venue
    category Category.first
  end
end
