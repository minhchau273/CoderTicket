class OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :ticket_type

  validates :quantity, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: MAX_QUANTITY }
  validates :order, :ticket_type, presence: true

  delegate :name, to: :ticket_type, prefix: true

  def subtotal
    ticket_type.price * quantity
  end
end
