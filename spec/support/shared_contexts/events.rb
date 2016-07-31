shared_context "three standard events" do
  let!(:event_1) { create(:event, name: "New event 1", starts_at: 2.weeks.since) }
  let!(:event_2) { create(:event, name: "Old event 2", starts_at: 2.weeks.ago) }
  let!(:event_3) { create(:event, name: "New event 3", starts_at: 1.week.since) }
end
