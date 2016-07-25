NEW_EMAIL = "chau@cs.com"

Given "I am at Register page" do
  visit register_path
end

When "I input username" do
  fill_in "user_name", with: "Cheetah"
end

And "I input valid email" do
  fill_in "user_email", with: NEW_EMAIL
end

And "I input invalid email" do
  fill_in "user_email", with: INVALID_EMAIL
end

And "I input password" do
  fill_in "user_password", with: CORRECT_PASSWORD
end

And "I input correct password confirmation" do
  fill_in "user_password_confirmation", with: CORRECT_PASSWORD
end

And "I input incorrect password confirmation" do
  fill_in "user_password_confirmation", with: INCORRECT_PASSWORD
end

Then "I can see error message about invalid email" do
  step "I can see \"#{SIGN_UP_WITH_INVALID_EMAIL_ERROR}\""
end

Then "I can see error message about incorrect password confirmation" do
  step "I can see \"#{SIGN_UP_WITH_INCORRECT_PASSWORD_CONFIRMATION_ERROR}\""
end

Then "I can see home page" do
  step "I can see \"Cheetah Ticket\""
end
