require "rails_helper"

RSpec.describe TicketType, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :event }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :max_quantity }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe "before create #set_remain" do
    let!(:type) { create(:ticket_type) }

    it "sets max quantity value for remain" do
      expect(type.remain).to eq type.max_quantity
    end
  end

  describe "#actual_max_quantity" do
    subject { type.actual_max_quantity }

    let(:type) { create(:ticket_type, max_quantity: remain) }

    context "the remain is less than the max quantity" do
      let(:remain) { 5 }

      it { is_expected.to eq remain }
    end

    context "the remain is not less than the max quantity" do
      let(:remain) { 10 }

      it { is_expected.to eq remain }
    end
  end
end
