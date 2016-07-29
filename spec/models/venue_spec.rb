require "rails_helper"

RSpec.describe Venue, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :region }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe "delegates" do
    it { is_expected.to delegate_method(:name).to(:region).with_prefix(true) }
  end
end
