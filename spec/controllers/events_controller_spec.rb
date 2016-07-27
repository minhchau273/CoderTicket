require "rails_helper"

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    let(:start_1) { DateTime.current + 2.weeks }
    let(:end_1) { start_1 + 2.hours }
    let(:event_1) { build(:event, starts_at: start_1, ends_at: end_1) }

    let(:start_2) { DateTime.current - 2.week }
    let(:end_2) { start_2 + 2.hours }
    let(:event_2) { build(:event, starts_at: start_2, ends_at: end_2) }

    let(:start_3) { DateTime.current + 1.week }
    let(:end_3) { start_3 + 2.hours }
    let(:event_3) { build(:event, starts_at: start_3, ends_at: end_3) }

    let(:expected_events) { [event_3, event_1] }

    before do
      event_1.save
      event_2.save
      event_3.save
      get :index
    end

    it "is success" do
      expect(response).to be_success
      expect(assigns(:events).count).to eq 2
    end

    it "shows a list of upcoming events ordered by started time" do
      event = assigns(:events)
      expect(event[0]).to eq expected_events[0]
      expect(event[1]).to eq expected_events[1]
    end
  end
end
