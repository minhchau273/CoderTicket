class OrdersController < ApplicationController
  def show
    if !current_user || current_user != (@order = Order.find(params[:id])).user
      @access_denied = true
    end
  end

  def new
    @event = Event.find(params[:event_id])
    if !@event.has_expired? && !current_user
      store_location_and_require_login
    end
    @order = Order.build_from_event(@event)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "Order successfully!"
      redirect_to order_path(@order)
    else
      render "new"
    end
  end

  private

  def order_params
    order_params = params.require(:order).permit(:event_id, order_items_attributes: [:quantity, :ticket_type_id])
    order_params["user_id"] = current_user.id
    order_params["order_items_attributes"] = order_params["order_items_attributes"].keep_if do |_, value|
      value["quantity"].to_i > 0
    end.values
    order_params
  end
end
