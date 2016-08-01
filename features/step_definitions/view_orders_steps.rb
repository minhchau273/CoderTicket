When "I visit an order details page" do
  visit order_path create(:order)
end

When "I visit my order details page" do
  user = User.find_by(email: VALID_EMAIL)
  visit order_path create(:order, user: user)
end
