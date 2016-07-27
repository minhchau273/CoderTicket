require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "formated_price" do
    let(:price) { 1000000 }
    let(:expected_price) { "1,000,000 VND" }
    it "returns this price with vietnamese format" do
      expect(formated_price(price)).to eq expected_price
    end
  end
end
