Given "I am at Home page" do
  visit root_path
end

When(/^I click "(.*?)"$/) do |button|
  click_on button
end

Then(/^I can see "(.*?)"$/) do |content|
  expect(page).to have_content content
end

Then(/^I cannot see "(.*?)"$/) do |content|
  expect(page).not_to have_content content
end

Then "I should be redirected to the Sign in page" do
  expect(page).to have_current_path login_path
end

Then "I sign in" do
  step "I click \"Sign In\""
  step "I input valid email and password to sign in"
  step "I click \"Sign In\""
  @current_user = User.find_by(email: VALID_EMAIL)
end

And "I have some events" do
  @events = [
    create(:event, name: "New event 1", creator: @registered_user, created_at: 2.days.ago, starts_at: 2.weeks.since),
    create(:expired_event, name: "Old event 2", creator: @registered_user, created_at: 3.days.ago),
    create(:event, name: "New event 3", creator: @registered_user, created_at: 5.days.ago, starts_at: 1.week.since)
  ]

  @ticket_types = [
    create(:ticket_type, name: "Type 1", event: @events[0], price: 50_000),
    create(:ticket_type, name: "Type 2", event: @events[0], price: 100_000, max_quantity: 5),
    create(:ticket_type, name: "Type 3", event: @events[2], price: 200_000)
  ]
end

And "I have some orders" do
  @orders = [
    create(:order, user: @registered_user, event: @events[0], created_at: DateTime.new(2016, 7, 7, 12, 30, 0)),
    create(:order, user: @registered_user, event: @events[2], created_at: DateTime.new(2016, 8, 7, 12, 30, 0))
  ]

  @order_items = [
    create(:order_item, order: @orders[0], ticket_type: @ticket_types[0], quantity: 2),
    create(:order_item, order: @orders[0], ticket_type: @ticket_types[1], quantity: 3),
    create(:order_item, order: @orders[1], ticket_type: @ticket_types[2], quantity: 5)
  ]
end
