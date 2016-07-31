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

  describe "delegates" do
    it { is_expected.to delegate_method(:name).to(:category).with_prefix(true) }
    it { is_expected.to delegate_method(:region_name).to(:venue) }
  end

  describe "scopes" do
    describe ".upcoming" do
      let!(:event_1) { create(:event, starts_at: 2.weeks.since) }
      let!(:event_2) { create(:event, starts_at: 2.weeks.ago) }
      let!(:event_3) { create(:event, starts_at: 1.week.since) }

      it "returns upcoming events" do
        expect(Event.upcoming).to eq [event_3, event_1]
      end
    end
  end

  describe ".search" do
    let(:keyword) { "  loReM  iPsUm   " }
    let!(:event_1) { create(:event, name: "Lorem event", starts_at: 2.weeks.since) }
    let!(:event_2) { create(:event, name: "Lorem ipsum", starts_at: 2.weeks.ago) }
    let!(:event_3) { create(:event, name: "Event ipsum", starts_at: 1.week.since) }

    it "returns the results satisfied the keyword" do
      expect(Event.search(keyword)).to eq [event_3, event_1]
    end
  end

  describe "#starts_at_to_s" do
    let(:event) { create(:event, starts_at: DateTime.new(2016, 7, 7, 8, 0, 0)) }
    let(:expected_date_string) { "Thursday, 07 Jul 2016  8:00 AM" }

    it "returns starts_at as string with full date format" do
      expect(event.starts_at_to_s).to eq expected_date_string
    end
  end

  describe "#starts_at_to_month" do
    let(:event) { create(:event, starts_at: DateTime.new(2016, 7, 7, 8, 0, 0)) }
    let(:expected_date_string) { "July" }

    it "returns starts_at as string with full month format" do
      expect(event.starts_at_to_month).to eq expected_date_string
    end
  end

  describe "#starts_at_to_day" do
    let(:event) { create(:event, starts_at: DateTime.new(2016, 7, 7, 8, 0, 0)) }
    let(:expected_date_string) { "07" }

    it "returns starts_at as string with day format" do
      expect(event.starts_at_to_day).to eq expected_date_string
    end
  end

  describe "#region_name" do
    let(:region_name) { Region::NAMES.last }
    let(:venue) { create(:venue, region: Region.find_by(name: region_name)) }
    let(:event) { create(:event, venue: venue) }

    it "returns region of this event" do
      expect(event.region_name).to eq region_name
    end
  end

  describe "#min_price" do
    let(:event) { create(:event) }
    let(:price_1) { 100_000 }
    let!(:ticket_type_1) { create(:ticket_type, price: price_1, event: event) }

    context "there is 1 ticket type" do
      it "returns the price of this type" do
        expect(event.min_price).to eq price_1
      end
    end

    context "there are more than 1 ticket type" do
      let(:price_2) { 50_000 }
      let!(:ticket_type_2) { create(:ticket_type, price: price_2, event: event) }

      it "returns the min price of these types" do
        expect(event.min_price).to eq price_2
      end
    end
  end

  describe "#has_expired?" do
    context "this event has expired" do
      let(:event) { create(:event, starts_at: 1.week.ago) }

      it "returns true" do
        expect(event.has_expired?).to be_truthy
      end
    end

    context "this event has not expired" do
      let(:event) { create(:event, starts_at: 1.week.since) }

      it "returns false" do
        expect(event.has_expired?).to be_falsey
      end
    end
  end
end
