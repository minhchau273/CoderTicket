require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #new" do
    subject { get :new, event_id: event.id }

    context "this event has expired" do
      let!(:event) { create(:event, starts_at: 1.week.ago) }

      it "is successful" do
        subject
        expect(response).to be_success
        expect(assigns(:event)).to eq event
      end
    end

    context "this event has not expired" do
      let!(:event) { create(:event, starts_at: 1.week.since) }

      context "user has already signed in" do
        login

        it "is successful" do
          subject
          expect(response).to be_success
          expect(assigns(:event)).to eq event
        end
      end

      context "user has not signed in yet" do
        before do
          expect(controller).to receive(:store_location_and_require_login).and_call_original
          subject
        end

        it "redirects to Sign in page" do
          expect(response).to redirect_to login_path
        end
      end
    end
  end

  describe "POST #create" do
    login

    let(:event) { create(:event) }
    let(:type) { create(:ticket_type, event: event, price: 50_000) }

    before do
      post :create, { event_id: "#{event.id}", "ticket_type_#{type.id}": { quantity: "1" } }
    end

    it "redirects to this order's details page" do
      expect(response).to redirect_to order_path(Order.last)
      expect(flash[:notice]).to eq "Order successfully!"
    end
  end

  describe "GET #show" do
    context "user has not signed in yet" do
      before do
        get :show, id: Faker::Number.between(1, 10)
      end

      it "is successful and returns access denied error" do
        expect(response).to be_success
        expect(assigns(:order)).to be_nil
        expect(assigns(:access_denied)).to be_truthy
      end
    end

    context "user has already signed in" do
      login

      subject { get :show, id: order.id }

      context "current user is not the owner of this order" do
        let(:order) { create(:order) }

        it "is successful and returns access denied error" do
          subject
          expect(response).to be_success
          expect(assigns(:order)).to eq order
          expect(assigns(:access_denied)).to be_truthy
        end
      end

      context "current user is the owner of this order" do
        let(:order) { create(:order, user: @user) }

        it "is successful" do
          subject
          expect(response).to be_success
          expect(assigns(:order)).to eq order
          expect(assigns(:access_denied)).to be_falsey
        end
      end
    end
  end
end
