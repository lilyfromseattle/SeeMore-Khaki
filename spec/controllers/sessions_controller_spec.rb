require 'spec_helper'

describe "SessionsController" do
  describe "POST create" do
    let(:returning_user) {User.new(
                            name: "Bookis",
                            email: "a@b.com",
                            provider: "github",
                            uid: "1234"
                            )}

    it "logs in returning user" do
    end
  end
end
