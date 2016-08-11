class EventsController < ApplicationController
  def index
    @keyword = params["search"]
    @events = @keyword.present? ? Event.search(@keyword) : Event.upcoming.includes(:venue, :category)
  end

  def show
    @event = Event.find(params[:id])
  end
end
