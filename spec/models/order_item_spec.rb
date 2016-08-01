require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :ticket_type }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :order }
    it { is_expected.to validate_presence_of :ticket_type }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe "#subtotal" do
    let(:type) { create(:ticket_type, price: 50_000) }
    let!(:item) { create(:order_item, ticket_type: type, quantity: 2 )}

    it "returns subtotal of this order item" do
      expect(item.subtotal).to eq 100_000
    end
  end
end
