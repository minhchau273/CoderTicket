class EventsController < ApplicationController
  def index
    @events = Event.upcoming
    if (@keyword = params["search"]).present?
      @events = Event.search(@keyword)
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
