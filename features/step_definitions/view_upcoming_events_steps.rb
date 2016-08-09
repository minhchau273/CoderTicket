Capybara.default_selector = :xpath

KEYWORD = "1"
DUMMY_KEYWORD = "dummy"

And "I can see list of upcoming events ordered by started time" do
  base_xpath = "(//h4[@class='card-title'])"
  expect(page).to have_selector "#{base_xpath}[1]", text: @events[2].name
  expect(page).to have_selector "#{base_xpath}[2]", text: @events[0].name
end

When "I click on an event" do
  step "I click \"#{@events[0].name}\""
end

And "I can see a list of ticket types in descending order of prices in details page" do
  name_xpath = "(//div[@class='col-md-6 ticket-name'])"
  expect(page).to have_selector "#{name_xpath}[1]", text: @ticket_types[1].name
  expect(page).to have_selector "#{name_xpath}[2]", text: @ticket_types[0].name

  price_xpath = "(//div[@class='col-md-6 price text-right'])"
  expect(page).to have_selector "#{price_xpath}[1]", text: formatted_price(@ticket_types[1].price)
  expect(page).to have_selector "#{price_xpath}[2]", text: formatted_price(@ticket_types[0].price)
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
