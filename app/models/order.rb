class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_many :order_items, inverse_of: :order

  validates :user, :event, presence: true

  delegate :name, to: :event, prefix: true

  accepts_nested_attributes_for :order_items

  def total
    order_items.map(&:subtotal).sum
  end
end
