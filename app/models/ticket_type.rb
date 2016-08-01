class TicketType < ActiveRecord::Base
  belongs_to :event

  validates :name, :price, :max_quantity, presence: true
  validates :name, uniqueness: true

  before_create :default_remain

  def actual_max_quantity
    remain < MAX_QUANTITY ? remain : MAX_QUANTITY
  end

  private

  def default_remain
    self.remain ||= max_quantity
  end
end
