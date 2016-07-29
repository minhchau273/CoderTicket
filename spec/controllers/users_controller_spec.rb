require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    before do
      get :new
    end

    it "is successful" do
      expect(assigns(:user)).to be_a_new User
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "valid user" do
      let(:user) { FactoryGirl.build(:user) }

      before do
        post :create, user: {
          name: user.name,
          email: user.email,
          password: user.password,
          password_confirmation: user.password_confirmation
        }
      end

      it "redirects to Home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "invalid user" do
      let(:user) { build(:user, email: "a.bc") }

      before do
        post :create, user: {
          name: user.name,
          email: user.email,
          password: user.password,
          password_confirmation: user.password_confirmation
        }
      end

      it "renders Register page" do
        expect(response).to render_template "authentication"
      end
    end
  end
end
