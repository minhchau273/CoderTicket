class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :ticket_type

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_save :update_subtotal

  def update_subtotal
    subtotal = ticket_type.price * quantity
  end
end
