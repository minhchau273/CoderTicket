When "I visit an unavailable order details page" do
  visit order_path INVALID_ID
end

When "I visit an order details page" do
  visit order_path create(:order)
end

When "I visit my order details page" do
  visit order_path @orders[0]
end

Then "I can see event's information" do
  step "I can see \"#{@events[0].name}\""
  step "I can see \"#{@events[0].venue.name}\""
  step "I can see \"#{@events[0].venue.full_address}\""
  step "I can see \"#{@events[0].starts_at_to_s}\""
end

And "I can see a list of ticket types in my order" do
  name_xpath = "(//td[@class='ticket-name'])"
  expect(page).to have_selector "#{name_xpath}[1]", text: @order_items[0].ticket_type.name
  expect(page).to have_selector "#{name_xpath}[2]", text: @order_items[1].ticket_type.name

  quantity_xpath = "(//td[@class='center ticket-quantity'])"
  expect(page).to have_selector "#{quantity_xpath}[1]", text: @order_items[0].quantity
  expect(page).to have_selector "#{quantity_xpath}[2]", text: @order_items[1].quantity

  subtotal_xpath = "(//td[@class='center ticket-subtotal'])"
  expect(page).to have_selector "#{subtotal_xpath}[1]", text: formatted_price(@order_items[0].subtotal)
  expect(page).to have_selector "#{subtotal_xpath}[2]", text: formatted_price(@order_items[1].subtotal)
end
