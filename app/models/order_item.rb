class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :ticket_type

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :order, :ticket_type, presence: true

  def subtotal
    ticket_type.price * quantity
  end
end
