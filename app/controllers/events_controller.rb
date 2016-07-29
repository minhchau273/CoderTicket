class EventsController < ApplicationController
  def index
    @events = Event.upcoming
    if (@keyword = params["search"]).present?
      keywords = @keyword.downcase.split.join("|")
      where_clause = "lower(name) similar to '%(#{keywords})%'"
      @events = @events.where(where_clause)
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
