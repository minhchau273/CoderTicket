class EventsController < ApplicationController
  def index
    @events = Event.where('starts_at > ?', DateTime.current).order(:starts_at)
  end

  def show
    @event = Event.find(params[:id])
  end
end
