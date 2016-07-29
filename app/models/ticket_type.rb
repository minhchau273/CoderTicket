class TicketType < ActiveRecord::Base
  belongs_to :event

  validates :name, :price, :max_quantity, presence: true
  validates :name, uniqueness: true
end
