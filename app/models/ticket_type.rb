class TicketType < ActiveRecord::Base
  belongs_to :event

  has_many :order_items

  validates :name, :price, :max_quantity, presence: true
  validates :name, uniqueness: true
  validates :max_quantity, numericality: { greater_than: 0 }

  def actual_max_quantity
    [max_quantity - order_items.sum(:quantity), MAX_QUANTITY].min
  end
end
