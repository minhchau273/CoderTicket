require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #new" do
    subject { get :new, event_id: event.id }

    context "this event has expired" do
      let!(:event) { create(:expired_event) }

      it "is successful" do
        subject
        expect(response).to be_success
        expect(assigns(:event)).to eq event
      end
    end

    context "this event has not expired" do
      let(:event) { create(:event) }
      let!(:ticket_type_1) { create(:ticket_type, event: event) }
      let!(:ticket_type_2) { create(:ticket_type, event: event) }
      let(:assigned_ticket_types) { assigns(:order).order_items.map(&:ticket_type) }

      context "user has already signed in" do
        login

        it "is successful and creates new order with some order items based on the ticket types of this event" do
          subject
          expect(response).to be_success
          expect(assigns(:event)).to eq event
          expect(assigned_ticket_types).to match_array [ticket_type_1, ticket_type_2]
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

    let(:subject) {
      post :create, {
        event_id: event.id,
        order: {
          event_id: event.id,
          order_items_attributes: {
            "0" => { "ticket_type_id": ticket_type_1.id, "quantity": "0" },
            "1" => { "ticket_type_id": ticket_type_2.id, "quantity": "1" },
            "2" => { "ticket_type_id": ticket_type_3.id, "quantity": "2" }
          } 
        }
      }
    }

    let(:event) { create(:event) }
    let!(:ticket_type_1) { create(:ticket_type, event: event, price: 50_000) }
    let!(:ticket_type_2) { create(:ticket_type, event: event, price: 100_000) }
    let!(:ticket_type_3) { create(:ticket_type, event: event, price: 200_000, max_quantity: 2) }
    let(:new_order) { Order.last }
    let(:order_items) { Order.last.order_items.order(:quantity) }
    let(:ordered_ticket_types) { order_items.map(&:ticket_type) }

    it "creates new order and redirects to this order's details page" do
      expect{ subject }.to change(Order, :count).by(1)
      expect(new_order.user_id).to eq @user.id
      expect(ordered_ticket_types).to match_array [ticket_type_2, ticket_type_3]
      expect(order_items[0].ticket_type).to eq ticket_type_2
      expect(order_items[1].ticket_type).to eq ticket_type_3
      expect(response).to redirect_to order_path(new_order)
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
