require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  context "when user has already signed in" do
    let(:user) { create(:user) }

    it { should be_able_to(:create, Order.new) }
    it { should be_able_to(:read, create(:order, user: user)) }
    it { should_not be_able_to(:read, create(:order, user: create(:user))) }
  end
end
