require "rails_helper"

RSpec.describe Region, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_inclusion_of(:name).in_array(["Ho Chi Minh", "Ha Noi", "Binh Thuan", "Da Nang", "Lam Dong"]) }
  end
end
