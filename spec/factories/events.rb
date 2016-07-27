FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    starts_at { DateTime.new(2016, 7, 7, 8, 0, 0) }
    ends_at { DateTime.new(2016, 7, 7, 11, 0, 0) }
    hero_image_url { Faker::Avatar.image }
    extended_html_description "<h1>Test</h1>"
    venue
    category { Category.first }
  end
end
