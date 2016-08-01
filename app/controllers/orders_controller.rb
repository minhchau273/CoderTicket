class OrdersController < ApplicationController
  def show
    if !current_user || current_user != (@order = Order.find(params[:id])).user
      @access_denied = true
    end
  end

  def new
    @order = Order.new
    @event = Event.find(params[:event_id])
    if !@event.has_expired? && !current_user
      store_location_and_require_login
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @order = Order.new(user_id: current_user.id, event_id: @event.id)
    @event.ticket_types.each do |type|
      if (quantity = params["ticket_type_#{type.id}".to_sym]["quantity"]).to_i > 0
        @order.order_items.new(ticket_type: type, quantity: quantity)
      end
    end

    if @order.save
      flash[:notice] = "Order successfully!"
      redirect_to order_path(@order)
    else
      render "new"
    end
  end
end
