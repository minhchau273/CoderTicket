require "rails_helper"

RSpec.describe TicketType, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :event }
    it { is_expected.to have_many :order_items }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :max_quantity }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_numericality_of(:max_quantity).is_greater_than(0) }
  end

  describe "#actual_max_quantity" do
    subject { ticket_type.actual_max_quantity }

    let(:ticket_type) { create(:ticket_type, max_quantity: 15) }
    let!(:order_item_1) { create(:order_item, ticket_type: ticket_type, quantity: 2) }

    context "the remain is not less than the max quantity" do
      it { is_expected.to eq 10 }
    end
    
    context "the remain is less than the max quantity" do
      let!(:order_item_2) { create(:order_item, ticket_type: ticket_type, quantity: 5) }

      it { is_expected.to eq 8 }
    end
  end
end
