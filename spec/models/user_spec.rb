require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { is_expected.to have_many(:orders).order(created_at: :desc) }
  end

  describe "validations" do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:password).is_at_least PASSWORD_MIN_LENGTH }
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value("afdf", "a.com", "abs@fds.2a").for(:email) }
  end

  describe "#total_amount" do
    let(:user) { create(:user) }
    let(:event) { create(:event) }
    let(:ticket_type_1) { create(:ticket_type, event: event, price: 50_000) }
    let(:ticket_type_2) { create(:ticket_type, event: event, price: 100_000) }
    let(:order_1) { create(:order, user: user, event: event) }
    let(:order_2) { create(:order, user: user, event: event) }
    let!(:order_item_1) { create(:order_item, order: order_1, ticket_type: ticket_type_1, quantity: 1) }
    let!(:order_item_2) { create(:order_item, order: order_2, ticket_type: ticket_type_2, quantity: 2) }

    it "returns the total amount of this user's orders" do
      expect(user.total_amount).to eq 250_000
    end
  end
end
