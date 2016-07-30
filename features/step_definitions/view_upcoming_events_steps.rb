Capybara.default_selector = :xpath

KEYWORD = "1"
DUMMY_KEYWORD = "dummy"

And "There are 3 events" do
  @events = [
    create(:event, name: "New event 1", starts_at: 2.weeks.since),
    create(:event, name: "Old event 2", starts_at: 2.weeks.ago),
    create(:event, name: "New event 3", starts_at: 1.week.since)
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

When "I input a dummy keyword" do
  fill_in "search", with: DUMMY_KEYWORD
end

Then "I press enter to search" do
  find_field("search").native.send_key(:enter)
end

And "I can see that dummy keyword in the search box" do
  expect(find_field("search").value).to eq DUMMY_KEYWORD
end

When "I input a keyword" do
  fill_in "search", with: KEYWORD
end

And "I can see that keyword in the search box" do
  expect(find_field("search").value).to eq KEYWORD
end

And "I can see the results" do
  step "I can see \"#{@events[0].name}\""
end

And "I cannot see the unexpected events" do
  step "I cannot see \"#{@events[1].name}\""
  step "I cannot see \"#{@events[2].name}\""
end
