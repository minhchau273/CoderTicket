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
      include_context 'three standard events'

      it "returns upcoming events" do
        expect(Event.upcoming).to eq [event_3, event_1]
      end
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

  describe ".search" do
    include_context "three standard events"

    context "no events found" do
      it "returns no events" do
        expect(Event.search("dummy")).to eq []
      end
    end

    context "having results" do
      let(:expected_events) { [event_3, event_1] }

      context "searching with case-insensitive" do
        it "returns the same results" do
          expect(Event.search("new")).to eq expected_events
          expect(Event.search("NEW")).to eq expected_events
        end
      end

      context "two events match two words in the keyword" do
        it "returns 2 events ordered by started time" do
          expect(Event.search("1 3")).to eq expected_events
        end
      end

      context "all events match the keyword" do
        it "returns 2 upcoming events and does not return expired events" do
          expect(Event.search("event")).to eq expected_events
          expect(Event.search("event")).not_to include event_2
        end
      end

      context "events match one of the keywords but not the other" do
        it "returns events that match that word" do
          expect(Event.search("1")).to eq [event_1]
        end
      end

      context "searching expired events" do
        it "returns no events" do
          expect(Event.search("old")).to eq []
        end
      end
    end
  end
end
