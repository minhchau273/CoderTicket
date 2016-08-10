FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    starts_at { 1.day.since }
    ends_at { starts_at + 2.hours }
    hero_image_url { Faker::Avatar.image }
    extended_html_description "<h1>Test</h1>"
    creator { create(:user) }
    venue
    category { Category.first }

    trait :expired do
      starts_at { 1.week.ago }
    end

    factory :expired_event, traits: [:expired]
  end
end
