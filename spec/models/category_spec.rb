require "rails_helper"

RSpec.describe Category, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_inclusion_of(:name).in_array(["Entertainment", "Learning", "Everything Else"]) }
  end
end
