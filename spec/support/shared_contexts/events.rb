shared_context 'three standard events' do
  let!(:event_1) { create(:event, starts_at: 2.weeks.since) }
  let!(:event_2) { create(:event, starts_at: 2.weeks.ago) }
  let!(:event_3) { create(:event, starts_at: 1.week.since) }
end
