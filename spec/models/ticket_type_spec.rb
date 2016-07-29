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
end
