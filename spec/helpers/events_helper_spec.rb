require "rails_helper"

RSpec.describe EventsHelper, type: :helper do
  describe "header_background_image_path" do
    it "returns a path with random number from 0 to 5" do
      expect(header_background_image_path).to match /\/images\/cover\/home-search-bg-0[0-5].jpg/
    end
  end
end
