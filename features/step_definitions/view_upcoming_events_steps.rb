Capybara.default_selector = :xpath

KEYWORD = "1"
DUMMY_KEYWORD = "dummy"

And "There are some events" do
  @events = [
    create(:event, name: "New event 1", starts_at: 2.weeks.since),
    create(:expired_event, name: "Old event 2"),
    create(:event, name: "New event 3", starts_at: 1.week.since)
  ]

  @ticket_types = [
    create(:ticket_type, name: "Type 1", event: @events[0], price: 50_000),
    create(:ticket_type, name: "Type 2", event: @events[0], price: 100_000, max_quantity: 5)
  ]
end

And "I can see list of upcoming events ordered by started time" do
  base_xpath = "(//h4[@class='card-title'])"
  expect(page).to have_selector "#{base_xpath}[1]", text: @events[2].name
  expect(page).to have_selector "#{base_xpath}[2]", text: @events[0].name
end

When "I click on an event" do
  step "I click \"#{@events[0].name}\""
end

Then "I can see the event's name" do
  step "I can see \"#{@events[0].name}\""
end

When "I input a dummy keyword" do
  @keyword = DUMMY_KEYWORD
  fill_in "search", with: @keyword
end

Then "I press enter to search" do
  find_field("search").native.send_key :enter
end

When "I input a keyword" do
  @keyword = KEYWORD
  fill_in "search", with: @keyword
end

And "I can see that keyword in the search box" do
  expect(find_field("search").value).to eq @keyword
end

And "I can see the results" do
  step "I can see \"#{@events[0].name}\""
end

And "I cannot see the unexpected events" do
  step "I cannot see \"#{@events[1].name}\""
  step "I cannot see \"#{@events[2].name}\""
end
