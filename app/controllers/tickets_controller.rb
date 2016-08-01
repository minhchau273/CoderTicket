class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    if !@event.has_expired? && !current_user
      store_location_and_require_login
    end
  end
end
