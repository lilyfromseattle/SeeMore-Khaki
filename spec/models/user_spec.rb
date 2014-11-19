require 'spec_helper'


describe User do
let(:user) { User.new(
    email:    "a@b.com",
    name: "Bookis",
    uid:      "1234",
    provider: "github")
  }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end
    it "requires an email" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "requires a username" do
      user.name = nil
      expect(user).to be_invalid
    end

    it "requires a uid" do
      user.uid = nil
      expect(user).to be_invalid
    end
    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end
  end


  # describe ".initialize_from_omniauth" do
  #   let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }
  #
  #   it "creates a valid user" do
  #     expect(user).to be_valid
  #   end
  #
  #   context "when it's invalid" do
  #     it "returns nil" do
  #       user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
  #       expect(user).to be_nil
  #     end
  #   end
  # end
end
