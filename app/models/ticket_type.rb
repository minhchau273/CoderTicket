class TicketType < ActiveRecord::Base
  belongs_to :event

  has_many :order_items

  validates :name, :price, :max_quantity, presence: true
  validates :name, uniqueness: true

  def actual_max_quantity
    remain = max_quantity - order_items.map(&:quantity).sum
    remain < MAX_QUANTITY ? remain : MAX_QUANTITY
  end
end
