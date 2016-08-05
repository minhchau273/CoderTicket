class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_many :order_items, inverse_of: :order, dependent: :destroy

  validates :user, :event, presence: true

  delegate :name, to: :event, prefix: true

  accepts_nested_attributes_for :order_items

  def self.build_from_event(event)
    order = Order.new
    order.order_items.build(event.ticket_types.map { |ticket_type| { ticket_type: ticket_type } })
    order
  end

  def total
    order_items.map(&:subtotal).sum
  end
end
