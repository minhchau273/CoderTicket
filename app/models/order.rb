class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_many :order_items

  before_save :update_total

  def update_total
    total = order_items.map(&:subtotal).sum
  end
end
