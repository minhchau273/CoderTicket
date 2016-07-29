require "rails_helper"

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    context "keyword is empty" do
      let(:upcoming_events) { double }

      before do
        expect(Event).to receive(:upcoming).and_return upcoming_events
        get :index
      end

      it "is successful and assigns upcoming events" do
        expect(response).to be_success
        expect(assigns(:events)).to eq upcoming_events
        expect(assigns(:keyword)).to be_nil
      end
    end

    context "keyword is not empty" do
      include_context 'three standard events'

      let(:keyword) { "1 3" }

      before do
        get :index, search: keyword
      end

      it "is successful and assigns results" do
        expect(response).to be_success
        expect(assigns(:events)).to eq [event_3, event_1]
        expect(assigns(:keyword)).to eq keyword
      end
    end
  end

  describe "GET #show" do
    let!(:event) { create(:event) }

    before do
      get :show, id: event.id
    end

    it "is successful" do
      expect(response).to be_success
      expect(assigns(:event)).to eq event
    end
  end
end
