NEW_EMAIL = "chau@cs.com"
USER_FIELDS = {
    username: "user_name",
    email: "user_email",
    password: "user_password",
    confirmed_password: "user_password_confirmation"
}

Given "I am at Register page" do
  visit register_path
end

When "I input username" do
  fill_in "user_name", with: "Cheetah"
end

And "I input valid email" do
  fill_in "user_email", with: NEW_EMAIL
end

And "I input password" do
  fill_in "user_password", with: CORRECT_PASSWORD
end

And "I input correct password confirmation" do
  fill_in "user_password_confirmation", with: CORRECT_PASSWORD
end

Then "I can see home page" do
  step "I can see \"Cheetah Ticket\""
end

And "I input $value to $field field to register" do |value, field|
  fill_in USER_FIELDS[field.to_sym], with: value
end
