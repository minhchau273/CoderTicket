require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #new" do
    context "this event does not exist" do
      before do
        get :new, event_id: INVALID_ID
      end

      it "redirects to Home page and shows error message" do
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "This event is not available."
      end
    end

    context "this event exists" do
      subject { get :new, event_id: event.id }
      
      context "this event has expired" do
        let!(:event) { create(:expired_event) }

        it "redirects to Home page and shows error message" do
          subject
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to eq EXPIRED_EVENT
        end
      end

      context "this event has not expired" do
        let(:event) { create(:event) }

        context "user has already signed in" do
          login

          let(:order) { create(:order) }

          before do
            expect(Order).to receive(:build_from_event).with(event).and_return order
          end

          it "is successful and creates new order with some order items based on the ticket types of this event" do
            subject
            expect(response).to be_success
            expect(assigns(:event)).to eq event
            expect(assigns(:order)).to eq order
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
  end

  describe "POST #create" do
    login

    subject do
      post :create, {
        event_id: event.id,
        order: {
          order_items_attributes: {
            "0" => { "ticket_type_id": ticket_type_1.id, "quantity": "0" },
            "1" => { "ticket_type_id": ticket_type_2.id, "quantity": "1" },
            "2" => { "ticket_type_id": ticket_type_3.id, "quantity": "2" }
          } 
        }
      }
    end

    let(:event) { create(:event) }
    let!(:ticket_type_1) { create(:ticket_type, event: event, price: 50_000) }
    let!(:ticket_type_2) { create(:ticket_type, event: event, price: 100_000) }
    let!(:ticket_type_3) { create(:ticket_type, event: event, price: 200_000) }
    let(:new_order) { Order.last }
    let(:order_items) { new_order.order_items.order(:quantity) }
    let(:ordered_ticket_types) { order_items.map(&:ticket_type) }

    it "creates new order and redirects to this order's details page" do
      expect{ subject }.to change(Order, :count).by(1)
      expect(new_order.user).to eq @user
      expect(new_order.event).to eq event
      expect(ordered_ticket_types).to eq [ticket_type_2, ticket_type_3]
      expect(response).to redirect_to order_path(new_order)
      expect(flash[:notice]).to eq "Order successfully!"
    end
  end

  describe "GET #show" do
    context "this order does not exist" do
      before do
        get :show, id: INVALID_ID
      end

      it "redirects to Home page and shows error message" do
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "This order is not available."
      end
    end

    context "this order exists" do
      subject { get :show, id: order.id }
      let(:order) { create(:order) }

      context "user has not signed in yet" do
        it "redirects to Home page and shows error message" do
          subject
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to eq ACCESS_DENIED
        end
      end

      context "user has already signed in" do
        login

        context "current user is not the owner of this order" do
          it "redirects to Home page and shows error message" do
            subject
            expect(response).to redirect_to root_path
            expect(flash[:alert]).to eq ACCESS_DENIED
          end
        end

        context "current user is the owner of this order" do
          before do
            order.user = @user
            order.save!
          end

          it "is successful" do
            subject
            expect(response).to be_success
            expect(assigns(:order)).to eq order
          end
        end
      end
    end
  end
end
