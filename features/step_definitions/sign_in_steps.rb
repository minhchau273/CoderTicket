VALID_EMAIL = "cheetah@cs.com"
INVALID_EMAIL = "cheetah.zxc.com"
CORRECT_PASSWORD = "123123"
INCORRECT_PASSWORD = "123456"

Given "I am at Login page" do
  visit login_path
end

And "There is a registered user" do
  create(:user, email: VALID_EMAIL)
end

When "I input invalid email to sign in" do
  fill_in "session_email", with: INVALID_EMAIL
end

When "I input valid email to sign in" do
  fill_in "session_email", with: VALID_EMAIL
end

And "I input incorrect password to sign in" do
  fill_in "session_password", with: INCORRECT_PASSWORD
end

And "I input correct password to sign in" do
  fill_in "session_password", with: CORRECT_PASSWORD
end

Then "I can see error message" do
  step "I can see \"#{LOGIN_FAIL_ERROR}\""
end

And "I can see my email" do
  step "I can see \"#{VALID_EMAIL}\""
end
