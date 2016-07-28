require "rails_helper"

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    include_context "three standard events"

    before do
      get :index
    end

    it "is success" do
      expect(response).to be_success
      expect(assigns(:events)).to eq [event_3, event_1]
    end
  end
end
