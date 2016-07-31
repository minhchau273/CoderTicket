require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :ticket_type }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :quantity }
    it do
      is_expected.to validate_numericality_of(:quantity).
        is_greater_than(0)
    end
  end
end
