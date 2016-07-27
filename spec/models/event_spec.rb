require "rails_helper"

RSpec.describe Event, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :venue }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many :ticket_types }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :extended_html_description }
    it { is_expected.to validate_presence_of :venue }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :starts_at }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:venue_id, :starts_at) }
  end

  describe "starts_at_to_s" do
    let(:start_time) { DateTime.new(2016, 7, 7, 8, 0, 0) }
    let(:event) { create(:event, starts_at: start_time) }
    let(:expected_date_string) { "Thursday, 07 Jul 2016  8:00 AM" }

    it "returns starts_at as string with full date format" do
      expect(event.starts_at_to_s).to eq expected_date_string
    end
  end

  describe "region_name" do
    let(:event) { create(:event) }
    let(:expected_region) { event.venue.region.name }

    it "returns region of this event" do
      expect(event.region_name).to eq expected_region
    end
  end

  describe "min_price" do
    let(:event) { create(:event) }
    let(:price_1) { 100000 }
    let(:ticket_type_1) { create(:ticket_type, price: price_1) }

    context "there is 1 ticket type" do
      before do
        ticket_type_1.event = event
        ticket_type_1.save
      end

      it "returns the price of this type" do
        expect(event.min_price).to eq price_1
      end
    end

    context "there are more than 1 ticket type" do
      let(:price_2) { 50000 }
      let(:ticket_type_2) { create(:ticket_type, price: price_2, event_id: event.id) }

      before do
        ticket_type_1.event = event
        ticket_type_2.event = event
        ticket_type_1.save
        ticket_type_2.save
      end

      it "returns the min price of these types" do
        expect(event.min_price).to eq price_2
      end
    end
  end
end
