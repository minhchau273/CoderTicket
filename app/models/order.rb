class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_many :order_items, inverse_of: :order, dependent: :destroy

  validates :user, :event, presence: true

  delegate :name, to: :event, prefix: true

  accepts_nested_attributes_for :order_items

  def self.build_from_event(event)
    order_items = event.ticket_types.map do |ticket_type|
      OrderItem.new(ticket_type: ticket_type)
    end
    Order.new(order_items: order_items)
  end

  def total
    order_items.map(&:subtotal).sum
  end
end
