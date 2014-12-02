require 'spec_helper'
require 'rails_helper'

describe FeedController do
  let(:z) {FeedController.new}
  let(:author) { Author.create(service: "test", name: "bookis", uid: "1234") }

  describe "call_api?" do
    it "does not call API if author last updated <1 hr ago" do
      expect(z.call_api?(author)).to eq false
    end

    it "will call API if author last updated >1 hr ago" do
      author.update(updated_at: Time.now - 7200)
      expect(z.call_api?(author)).to eq true
    end
  end
end
