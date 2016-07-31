require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :event }
    it { is_expected.to have_many :order_items }
  end
end
