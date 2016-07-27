Capybara.default_selector = :xpath

And "There are 3 events" do
  Category.create(name: Category::NAMES.first)
  Region.create(name: Region::NAMES.first)
  start_1 = DateTime.current + 2.weeks
  end_1 = start_1 + 2.hours
  name_1 = "Event 1"
  create(:event, starts_at: start_1, ends_at: end_1, name: name_1)

  start_2 = DateTime.current - 2.week
  end_2 = start_2 + 2.hours
  name_2 = "Event 2"
  create(:event, starts_at: start_2, ends_at: end_2, name: name_2)

  start_3 = DateTime.current + 1.week
  end_3 = start_3 + 2.hours
  name_3 = "Event 3"
  create(:event, starts_at: start_3, ends_at: end_3, name: name_3)
end

And "I can see list of upcoming events ordered by started time" do
  events = ["Event 3", "Event 1"]
  base_xpath = "(//h4[@class='card-title'])"
  expect(page).to have_selector("#{base_xpath}[1]", :text => events[0])
  expect(page).to have_selector("#{base_xpath}[2]", :text => events[1])
end
