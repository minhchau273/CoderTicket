And "I visit the Order management page" do
  visit orders_path
end

Then "I should be at the Order management page" do
  expect(page).to have_current_path orders_path
end

And "I can see the number of orders and the total amount of my orders" do
  step "I can see \"2 orders\""
  step "I can see \"1,400,000 VND\""
end

And "I can see a list of my orders in descending order of booking date" do
  name_xpath = "(//td[@class='event-name'])"
  expect(page).to have_selector "#{name_xpath}[1]", text: @orders[1].event_name
  expect(page).to have_selector "#{name_xpath}[2]", text: @orders[0].event_name

  booking_date_xpath = "(//td[@class='center booking-time'])"
  expect(page).to have_selector "#{booking_date_xpath}[1]", text: @orders[1].created_at_to_s
  expect(page).to have_selector "#{booking_date_xpath}[2]", text: @orders[0].created_at_to_s

  total_xpath = "(//td[@class='center order-total'])"
  expect(page).to have_selector "#{total_xpath}[1]", text: formatted_price(@orders[1].total)
  expect(page).to have_selector "#{total_xpath}[2]", text: formatted_price(@orders[0].total)
end

When "I click to an order" do
  find(:xpath, "(//td[@class='event-name'])[2]").click
end

Then "I can see this order details" do
  step "I can see \"#{@orders[0].event_name}\""
  step "I can see \"#{formatted_price(@orders[0].total)}\""
end

Then "I click my email at the top to view my orders" do
  step "I click \"Welcome #{@current_user.email}\""
end
