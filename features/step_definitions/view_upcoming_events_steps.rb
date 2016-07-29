Capybara.default_selector = :xpath

And "There are 3 events" do
  @events = [
    create(:event, starts_at: 2.weeks.since),
    create(:event, starts_at: 2.weeks.ago),
    create(:event, starts_at: 1.week.since)
  ]
end

And "I can see list of upcoming events ordered by started time" do
  base_xpath = "(//h4[@class='card-title'])"
  expect(page).to have_selector("#{base_xpath}[1]", text: @events[2].name)
  expect(page).to have_selector("#{base_xpath}[2]", text: @events[0].name)
end

When "I click on an event" do
  step "I click \"#{@events[0].name}\""
end

Then "I can see the event's name" do
  step "I can see \"#{@events[0].name}\""
end
