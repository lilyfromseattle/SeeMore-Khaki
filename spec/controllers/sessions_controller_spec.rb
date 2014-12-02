require 'spec_helper'
require 'rails_helper'

describe SessionsController do
  # describe "POST #create" do
  #   let(:returning_user) {User.create(
  #                           name: "Bookis",
  #                           email: "a@b.com",
  #                           provider: "github",
  #                           uid: "1234"
  #                           )}
  #
  #   it "logs in returning user" do
  #     post :create, params: {provider: returning_user[:provider], uid: returning_user[:uid]}
  #     expect(session[:current_user]).to eq user.id
  #   end
  # end
    

  #LKD wrote the following test (copying from lecture, but still.)
  describe 'GET create' do
    pending 'creates a user' do
      auth_hash = double("auth_hash", provider: "test", uid: "1234")
      expect(request).to receive(:env).and_return({"omniauth.auth" => auth_hash})
      expect { get :create, provider: "test" }.to change(User, :count).by(1)
              #This is a block.
      #we expect that after the execution of that block, the count of users in the db will change by 1
    end
  end
end
