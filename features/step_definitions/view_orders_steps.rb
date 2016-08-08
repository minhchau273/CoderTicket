When "I visit an unavailable order details page" do
  visit order_path INVALID_ID
end

When "I visit an order details page" do
  visit order_path create(:order)
end

When "I visit my order details page" do
  visit order_path create(:order, user: @current_user)
end
