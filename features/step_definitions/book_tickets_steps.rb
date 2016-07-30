When "I click Book Now button" do
  find(:css, ".book-button").click
end

Then "I should be at the Booking page" do
  expect(page).to have_current_path(new_event_ticket_path(@events[0]))
end
