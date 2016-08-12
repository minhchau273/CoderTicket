class Users::EventsController < ApplicationController
  layout "settings"

  before_action :load_user

  def index
    authorize! :view_events_of, @user
    @events = current_user.events.includes(:venue)
  end

  private

  def load_user
    @user = User.new(id: params[:user_id])
  end
end
