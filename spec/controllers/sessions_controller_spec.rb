require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    context "user has already logged in" do
      login

      before do
        get :new
      end

      it "redirects to Home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "user hasn't logged in yet" do
      before do
        get :new
      end

      it "shows Login page" do
        expect(response).to be_success
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    before do
      post :create, session: session_params
    end

    context "invalid user" do
      context "user inputs invalid email" do
        let(:invalid_email) { "abc@ab.com" }
        let(:session_params) {{ email: invalid_email }}

        it "redirects to Login page" do
          expect(response).to redirect_to login_path(error: true)
        end
      end

      context "user inputs valid email and incorrect password" do
        let(:incorrect_password) { "123456" }
        let(:session_params) {{ email: user.email, password: incorrect_password }}

        it "redirects to Login page" do
          expect(response).to redirect_to login_path(error: true)
        end
      end
    end

    context "valid user" do
      context "user inputs valid email and correct password" do
        let(:session_params) {{ email: user.email, password: user.password }}

        it "redirects to Home page" do
          expect(response).to redirect_to root_path
          expect(session[:user_id]).to eq user.id
        end
      end
    end
  end

  describe "DELETE #destroy" do
    login

    before do
      delete :destroy
    end

    it "destroys session and redirects to Home page" do
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end
  end
end
