class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_many :order_items

  validates :user, :event, presence: true

  def total
    order_items.map(&:subtotal).sum
  end
end
