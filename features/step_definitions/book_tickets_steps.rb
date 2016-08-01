When "I click Book Now button" do
  find(:css, ".book-button").click
end

Then "I should be at the Booking page" do
  expect(page).to have_current_path(new_event_ticket_path @events[0])
end

When "I visit an expired event page" do
  visit event_path @events[1]
end

Then "The Book Now button should be disabled" do
  expect(page).to have_css ".book-button:enabled"
end

When "I visit an expired event's booking page" do
  visit new_event_ticket_path @events[1]
end

And(/^I wait for (\d+) seconds?$/) do |n|
  sleep n.to_i
end

Then "I should be at the Home page" do
  expect(page).to have_current_path root_path
end
