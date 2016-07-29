VALID_EMAIL = "cheetah@cs.com"
CORRECT_PASSWORD = "123123"
SIGN_IN_FIELDS = {
    email: "sign_in_email",
    password: "sign_in_password"
}

Given "I am at Login page" do
  visit login_path
end

And "There is a registered user" do
  create(:user, email: VALID_EMAIL)
end

When "I input valid email to sign in" do
  fill_in "sign_in_email", with: VALID_EMAIL
end

And "I input correct password to sign in" do
  fill_in "sign_in_password", with: CORRECT_PASSWORD
end

And "I can see my email" do
  step "I can see \"#{VALID_EMAIL}\""
end

And "I input $value to $field field" do |value, field|
  fill_in SIGN_IN_FIELDS[field.to_sym], with: value
end
