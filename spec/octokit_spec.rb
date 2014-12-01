
describe Octokit do

  describe ".client" do
    it "creates an Octokit::Client" do
      expect(Octokit.client).to be_kind_of Octokit::Client
    end
    it "returns a fresh client when options are not the same" do
      client = Octokit.client
      Octokit.access_token = "87614b09dd141c22800f96f11737ade5226d7ba8"
      client_two = Octokit.client
      client_three = Octokit.client
      expect(client).not_to eq(client_two)
      expect(client_three).to eq(client_two)
    end
  end
end
