require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    context "user has already signed in" do
      login

      let(:order_1) { create(:order, user: @user, created_at: 3.weeks.ago) }
      let(:order_2) { create(:order, user: @user, created_at: 2.weeks.ago) }
      let!(:order_3) { create(:order) }
      let!(:orders) { [order_2, order_1] }

      before do
        subject
      end

      it "is successful" do
        expect(response).to be_success
        expect(assigns(:orders).to_a).to eq orders
        expect(subject).to render_template "settings"
      end
    end

    context "user has not signed in yet" do
      before do
        subject
      end

      it_behaves_like "require signing in" do
        let(:previous_path) { orders_path }
      end
    end
  end

  describe "GET #new" do
    subject { get :new, event_id: event_id }

    context "this event does not exist" do
      it_behaves_like "show error", "This event is not available." do
        let(:event_id) { INVALID_ID }
        before { subject }
      end
    end

    context "this event exists" do
      context "this event has expired" do
        it_behaves_like "show error", EXPIRED_EVENT do
          let(:event_id) { create(:expired_event).id }
          before { subject }
        end
      end

      context "this event has not expired" do
        let(:event) { create(:event) }
        let(:event_id) { event.id }

        context "user has already signed in" do
          login

          let(:order) { create(:order) }

          before do
            expect(Order).to receive(:build_from_event).with(event).and_return order
            subject
          end

          it "is successful and creates new order with some order items based on the ticket types of this event" do
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

          it_behaves_like "require signing in" do
            let(:previous_path) { new_event_order_path event }
          end
        end
      end
    end
  end

  describe "POST #create" do
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

    context "user has not signed in yet" do
      it_behaves_like "require signing in" do
        before { subject }
        let(:previous_path) { event_orders_path event }
      end
    end

    context "user has already signed in" do
      login

      it "creates new order and redirects to this order's details page" do
        expect{ subject }.to change(Order, :count).by(1)
        expect(new_order.user).to eq @user
        expect(new_order.event).to eq event
        expect(ordered_ticket_types).to eq [ticket_type_2, ticket_type_3]
        expect(response).to redirect_to order_path(new_order)
        expect(flash[:notice]).to eq ORDER_SUCCESSFULLY
      end
    end
  end

  describe "GET #show" do
    subject { get :show, id: order_id }

    context "this order does not exist" do
      it_behaves_like "show error", "This order is not available." do
        let(:order_id) { INVALID_ID }
        before { subject }
      end
    end

    context "this order exists" do
      let(:order) { create(:order) }
      let(:order_id) { order.id }

      context "user has not signed in yet" do
        it_behaves_like "show error", ACCESS_DENIED do
          before { subject }
        end
      end

      context "user has already signed in" do
        login

        context "current user is not the owner of this order" do
          it_behaves_like "show error", ACCESS_DENIED do
            before { subject }
          end
        end

        context "current user is the owner of this order" do
          let(:order) { create(:order, user: @user) }

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
