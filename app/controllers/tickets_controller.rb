class TicketsController < ApplicationController
  def new
    if current_user
      @event = Event.find(params[:event_id])
    else
      store_location_and_require_login
    end
  end
end
