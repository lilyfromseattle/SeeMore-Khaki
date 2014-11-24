require 'spec_helper'

describe User do
let(:user) { User.new(
    email:    "a@b.com",
    name:     "Bookis",
    uid:      "1234",
    provider: "github")
  }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end
##### commented out because not all APIs return email address
    # it "requires an email" do
    #   user.email = nil
    #   expect(user).to be_invalid
    # end
    #
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

  describe "self.find_by_provider" do

    it "finds user by provider and uid" do
      user.save
      expect(User.find_by_provider(user[:provider], user[:uid]).email).to eq "a@b.com"
    end

    it "returns nil for non-existent (new) user" do
      user.save
      expect(User.find_by_provider("twitter", user[:uid])).to eq nil
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
