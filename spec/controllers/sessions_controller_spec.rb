require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    let(:user) { create(:user) }

    context "user has already logged in" do
      before do
        session[:user_id] = user.id
        get :new
      end

      it "redirects to Home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "user hasn't logged in yet" do
      before do
        session[:user_id] = nil
        get :new
      end

      it "shows Login page" do
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    let(:user) { build(:user) }

    context "invalid user" do
      context "user inputs invalid email" do
        let(:invalid_email) { "abc@ab.com" }

        before do
          post :create, session: {
            email: invalid_email
          }
        end

        it "redirects to Login page" do
          expect(response).to redirect_to login_path(error: true)
        end
      end

      context "user inputs valid email and incorrect password" do
        let(:incorrect_password) { "123456" }

        before do
          user.save
          post :create, session: {
            email: user.email,
            password: incorrect_password
          }
        end

        it "redirects to Login page" do
          expect(response).to redirect_to login_path(error: true)
        end
      end
    end

    context "valid user" do
      context "user inputs valid email and correct password" do
        before do
          user.save
          post :create, session: {
            email: user.email,
            password: user.password
          }
        end

        it "redirects to Home page" do
          expect(response).to redirect_to root_path
          id = User.find_by_email(user.email).id
          expect(session[:user_id]).to eq id
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:user_id] = 1
      delete :destroy
    end

    it "destroys session and redirects to Home page" do
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end
  end
end
