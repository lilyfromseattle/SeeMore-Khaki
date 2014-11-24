require 'spec_helper'
require 'rails_helper'

describe SessionsController do
  describe "POST #create" do
    let(:returning_user) {User.create(
                            name: "Bookis",
                            email: "a@b.com",
                            provider: "github",
                            uid: "1234"
                            )}

    it "logs in returning user" do
      post :create, params: {provider: returning_user[:provider], uid: returning_user[:uid]}
      expect(session[:current_user]).to eq user.id
    end
  end
end
