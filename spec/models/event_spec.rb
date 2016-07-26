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
    subject { build(:event) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:venue_id, :starts_at) }
  end

  describe "starts_at_to_s" do
    let(:event) { create(:event) }
    let(:expected_date_string) { "Thursday, 07 Jul 2016  8:00 AM" }

    it "returns starts_at as string with full date format" do
      expect(event.starts_at_to_s).to eq expected_date_string
    end
  end
end
