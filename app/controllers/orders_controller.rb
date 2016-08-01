class OrdersController < ApplicationController
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
      redirect_to event_path(@event)
    else
      render "new"
    end
  end
end
