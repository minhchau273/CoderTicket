require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  context "when user has already signed in" do
    let(:user) { create(:user) }

    it { is_expected.to be_able_to(:create, Order.new) }
    it { is_expected.to be_able_to(:read, create(:order, user: user)) }
    it { is_expected.not_to be_able_to(:read, create(:order, user: create(:user))) }
    it { is_expected.to be_able_to(:view_events_of, user) }
  end
end
