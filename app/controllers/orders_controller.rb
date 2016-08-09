class OrdersController < ApplicationController
  layout "settings", only: [:index]

  before_action :load_event, only: :new
  before_action :check_expired_event, only: :new
  before_action :authenticate_resource, only: [:index, :new, :create]
  before_action :load_order, only: :show
  authorize_resource only: :show

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.build_from_event(@event)
  end

  def create
    if (@order = Order.new(order_params)).save
      redirect_to order_path(@order), notice: ORDER_SUCCESSFULLY
    else
      render "new"
    end
  end

  private

  def load_order
    @order = Order.find(params[:id])
  end

  def load_event
    @event = Event.find(params[:event_id])
  end

  def check_expired_event
    if @event.has_expired?
      redirect_to root_path, alert: EXPIRED_EVENT
    end
  end

  def order_params
    order_params = params.require(:order).permit(:event_id, order_items_attributes: [:quantity, :ticket_type_id])
    order_params["user_id"] = current_user.id
    order_params["event_id"] = params[:event_id]
    order_params["order_items_attributes"] = order_params["order_items_attributes"].keep_if do |_, value|
      value["quantity"].to_i > 0
    end.values
    order_params
  end
end
