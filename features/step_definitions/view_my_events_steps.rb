And "I visit the Event management page" do
  visit user_events_path @registered_user
end

And "I visit the the other one's Event management page" do
  visit user_events_path create(:user)
end

And "I can see Event tab is highlighted" do
  page.find(:xpath, "//div[contains(@class, 'settings-sidebar')]//li[2]")["active"]
  expect(page.find(:xpath, "//div[contains(@class, 'settings-sidebar')]//li[1]")["active"]).to be_falsey
end

And "I can see the number of events" do
  step "I can see \"3 events\""
end

And "I can see a list of my events in descending event of created date" do
  name_xpath = "(//td[@class='event-name'])"
  expect(page).to have_selector "#{name_xpath}[1]", text: @events[0].name
  expect(page).to have_selector "#{name_xpath}[2]", text: @events[1].name
  expect(page).to have_selector "#{name_xpath}[3]", text: @events[2].name

  starting_date_xpath = "(//td[@class='center starting-time'])"
  expect(page).to have_selector "#{starting_date_xpath}[1]", text: @events[0].starts_at_to_s
  expect(page).to have_selector "#{starting_date_xpath}[2]", text: @events[1].starts_at_to_s
  expect(page).to have_selector "#{starting_date_xpath}[3]", text: @events[2].starts_at_to_s

  region_xpath = "(//td[@class='center event-region'])"
  expect(page).to have_selector "#{region_xpath}[1]", text: @events[0].region_name
  expect(page).to have_selector "#{region_xpath}[2]", text: @events[1].region_name
  expect(page).to have_selector "#{region_xpath}[3]", text: @events[2].region_name
end

And "I can see the expired events are blurred" do
  page.find(:xpath, "//table[contains(@class, 'table')]//tr[3]")["expired-event"]
  expect(page.find(:xpath, "//table[contains(@class, 'table')]//tr[2]")["expired-event"]).to be_falsey
  expect(page.find(:xpath, "//table[contains(@class, 'table')]//tr[4]")["expired-event"]).to be_falsey
end
