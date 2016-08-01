require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :event }
    it { is_expected.to have_many :order_items }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :event }
  end

  describe "#total" do
    let(:event) { create(:event) }
    let(:order) { create(:order, event: event) }
    let(:type_1) { create(:ticket_type, event: event, price: 50_000) }
    let(:type_2) { create(:ticket_type, event: event, price: 100_000) }
    let!(:item_1) { create(:order_item, order: order, ticket_type: type_1, quantity: 1)}
    let!(:item_2) { create(:order_item, order: order, ticket_type: type_2, quantity: 2)}

    it "returns total of this order" do
      expect(order.total).to eq 250_000
    end
  end
end
