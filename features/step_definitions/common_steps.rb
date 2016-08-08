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
