When "I click Book Now button" do
  find(:css, ".book-button").click
end

Then "I should be at the Booking page" do
  expect(page).to have_current_path new_event_order_path @events[0]
end

When "I visit an expired event page" do
  visit event_path @events[1]
end

Then "The Book Now button should be disabled" do
  expect(page).to have_css ".book-button:enabled"
end

When "I visit an expired event's booking page" do
  visit new_event_order_path @events[1]
end

And(/^I wait for (\d+) seconds?$/) do |n|
  sleep n.to_i
end

Then "I should be at the Home page" do
  expect(page).to have_current_path root_path
end

And "I can see a list of ticket types" do
  name_xpath = "(//td[@class='ticket-name'])"
  expect(page).to have_selector("#{name_xpath}[1]", text: @ticket_types[0].name)
  expect(page).to have_selector("#{name_xpath}[2]", text: @ticket_types[1].name)

  price_xpath = "(//td[@class='ticket-price center'])"
  expect(page).to have_selector("#{price_xpath}[1]", text: formatted_price(@ticket_types[0].price))
  expect(page).to have_selector("#{price_xpath}[2]", text: formatted_price(@ticket_types[1].price))

  last_quantity_option_xpath = "(//select[@class='quantity-select']/option[last()])"
  expect(page).to have_selector("#{last_quantity_option_xpath}[1]", text: @ticket_types[0].actual_max_quantity)
  expect(page).to have_selector("#{last_quantity_option_xpath}[2]", text: @ticket_types[1].actual_max_quantity)
end

When "I select the quantity of tickets" do
  select "2", from: "order_order_items_attributes_0_quantity"
end

Then "I should be redirected to the order's details page" do
  expect(page).to have_current_path order_path Order.last
end
