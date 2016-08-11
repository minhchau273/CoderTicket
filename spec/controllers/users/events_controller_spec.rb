require "rails_helper"

RSpec.describe Users::EventsController, type: :controller do
  describe "GET #index" do
    subject { get :index, user_id: user }

    context "user has already signed in" do
      login

      context "user accesses the other one's events" do
        let(:user) { create(:user) }

        it_behaves_like "show error", ACCESS_DENIED do
          before { subject }
        end
      end

      context "user accesses his/her events" do
        let(:user) { @user }
        let(:event_1) { create(:event, creator: @user, created_at: 3.weeks.ago) }
        let(:event_2) { create(:expired_event, creator: @user, created_at: 2.weeks.ago) }
        let!(:event_3) { create(:event) }
        let!(:events) { [event_2, event_1] }

        before do
          subject
        end

        it "is successful" do
          expect(response).to be_success
          expect(assigns(:events).to_a).to eq events
          expect(subject).to render_template "settings"
        end
      end
    end

    context "user has not signed in yet" do
      let(:user) { create(:user) }

      it_behaves_like "show error", ACCESS_DENIED do
        before { subject }
      end
    end
  end
end
