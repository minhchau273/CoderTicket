require 'rails_helper'

RSpec.describe SignIn, type: :model do
  let(:email) { "a@sample.com" }
  let(:password) { "123456" }
  let(:incorrect_email) { "invalid@sample.com" }
  let(:incorrect_password) { "123" }

  describe "validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }

    describe "validate #check_user_and_password" do
      let(:sign_in) { SignIn.new(sign_in_params) }

      context "there is an existing user with given email" do
        let!(:user) { create(:user, email: email, password: password, password_confirmation: password) }

        context "correct password" do
          let(:sign_in_params) {{ email: email, password: password }}

          it "does not raise errors" do
            expect(sign_in).to be_valid
          end
        end

        context "incorrect password" do
          let(:sign_in_params) {{ email: email, password: incorrect_password }}

          it "raises errors" do
            expect(sign_in).to be_invalid
            expect(sign_in.errors[:password]).to eq ["does not match"]
          end
        end
      end

      context "there is not an existing user with given email" do
        let(:sign_in_params) {{ email: incorrect_email }}

        it "raises errors" do
          expect(sign_in).to be_invalid
          expect(sign_in.errors[:email]).to eq ["is not found"]
        end
      end
    end
  end

  describe "delegates" do
    it { is_expected.to delegate_method(:id).to(:user).with_prefix(true) }
  end

  describe "#initialize" do
    context "new object without params" do
      let(:sign_in) { SignIn.new }

      it "new a sign_in object with empty email and empty password" do
        expect(sign_in.email).to be_nil
        expect(sign_in.password).to be_nil
      end
    end

    context "new object with params" do
      let(:sign_in_params) {{ email: email, password: password }}
      let(:sign_in) { SignIn.new(sign_in_params) }

      it "new a sign_in object with assigned email and assigned password" do
        expect(sign_in.email).to eq email
        expect(sign_in.password).to eq password
      end
    end
  end

  describe "#user" do
    let!(:user) { create(:user, email: email) }

    context "this email exists" do
      let(:sign_in) { SignIn.new(email: email) }

      it "returns user having this email" do
        expect(sign_in.user).to eq user
      end
    end

    context "this email does not exist" do
      let(:sign_in) { SignIn.new(email: incorrect_email) }

      it "returns nil" do
        expect(sign_in.user).to be_nil
      end
    end
  end
end
