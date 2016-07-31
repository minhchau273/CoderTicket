require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "GET #new" do
      context "this event has expired" do
        let!(:event) { create(:event, starts_at: 1.week.ago) }

        before do
          get :new, event_id: event.id
        end

        it "is successful" do
          expect(response).to be_success
          expect(assigns(:event)).to eq event
        end
      end

    context "this event has not expired" do
      let!(:event) { create(:event, starts_at: 1.week.since) }

      context "user has already signed in" do
        login

        before do
          get :new, event_id: event.id
        end

        it "is successful" do
          expect(response).to be_success
          expect(assigns(:event)).to eq event
        end
      end

      context "user has not signed in yet" do
        before do
          session[:user_id] = nil
          get :new, event_id: event.id
          # expect(controller).to receive(:store_location_and_require_login)
        end

        it "is successful and redirects to Sign in page" do
          expect(response).not_to be_success
        end
      end
    end
    
  end
end
