And "There is a sold out ticket type" do
  @sold_out_ticket_type = create(:ticket_type, name: "Type 3", event: @events[0], price: 80_000, max_quantity: 5)
  order = create(:order, event: @events[0])
  create(:order_item, order: order, ticket_type: @sold_out_ticket_type, quantity: @sold_out_ticket_type.max_quantity)
end

When "I visit an unavailable event's booking page" do
  visit new_event_order_path INVALID_ID
end

And "I can see event not found message" do
  step "I can see \"#{EVENT_NOT_FOUND}\""
end

When "I click Book Now button" do
  sleep 1
  find(:css, ".book-now-button").click
end

Then "I should be at the Booking page" do
  expect(page).to have_current_path new_event_order_path @events[0]
end

When "I visit an expired event page" do
  visit event_path @events[1]
end

Then "The Book Now button should be disabled" do
  expect(page).to have_css ".book-now-button:enabled"
end

When "I visit an expired event's booking page" do
  visit new_event_order_path @events[1]
end

And "I can see expired event message" do
  step "I can see \"#{EXPIRED_EVENT}\""
end

Then "I should be at the Home page" do
  expect(page).to have_current_path root_path
end

And "I can see a list of ticket types in descending order of prices" do
  name_xpath = "(//td[@class='ticket-name'])"
  expect(page).to have_selector "#{name_xpath}[1]", text: @ticket_types[1].name
  expect(page).to have_selector "#{name_xpath}[2]", text: @sold_out_ticket_type.name
  expect(page).to have_selector "#{name_xpath}[3]", text: @ticket_types[0].name

  price_xpath = "(//td[@class='ticket-price center'])"
  expect(page).to have_selector "#{price_xpath}[1]", text: formatted_price(@ticket_types[1].price)
  expect(page).to have_selector "#{price_xpath}[2]", text: formatted_price(@sold_out_ticket_type.price)
  expect(page).to have_selector "#{price_xpath}[3]", text: formatted_price(@ticket_types[0].price)

  last_quantity_option_xpath = "(//select[@class='quantity-select']/option[last()])"
  expect(page).to have_selector "#{last_quantity_option_xpath}[1]", text: @ticket_types[1].actual_max_quantity
  expect(page).to have_selector "#{last_quantity_option_xpath}[2]", text: @ticket_types[0].actual_max_quantity
end

When "I select the quantity of tickets" do
  select "2", from: "order_order_items_attributes_0_quantity"
end

Then "I should be redirected to the order's details page" do
  expect(page).to have_current_path order_path Order.last
end

And "I can see the order's total" do
  step "I can see \"200,000 VND\""
end
