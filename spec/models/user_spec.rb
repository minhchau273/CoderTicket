require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:password).is_at_least PASSWORD_MIN_LENGTH }
    it { is_expected.to validate_uniqueness_of :email }
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value("afdf", "a.com", "abs@fds.2a").for(:email) }
  end
end
