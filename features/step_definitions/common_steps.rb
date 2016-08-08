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
