module ApplicationHelper
  def formatted_price(price)
    "#{number_with_precision(price, precision: 0, delimiter: ',')} VND"
  end
end
