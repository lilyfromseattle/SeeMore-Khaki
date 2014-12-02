describe InstagramHelper do

  describe "query_for_users" do
    let(:bookises) { {"data" => [{"username" => "bookis", "id" => "5665602"}, {"username" => "fakebookis", "id" => "123456" }]} }

    it "returns an array of users" do
      url = "https://api.instagram.com/v1/users/search?q=bookis&client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
      HTTParty.stub(:get).with(url) { bookises }
      z = InstagramHelper.new
      z.query_for_users("bookis")
      expect(z.results_array[0][:name]).to eq "bookis"
      expect(z.results_array[1][:name]).to eq "fakebookis"
    end
  end

  # THIS IS SO UGLY I AM SORRY
  describe "query_for_igs" do
    let(:user) { User.create(name: "tinycat", provider: "cats4all", uid: "meow") }
    let(:igs) { {"data" => [
      { "user" => { "id" => "yowl" },
        "created_time" => Time.now,
        "images" => { "thumbnail" => { "url" => "orangecat.jpg" } },
        "link" => "http://instagram.com/q4rEI938" }
        ]
      }
    }

    it "returns an array of instagram posts" do
      Author.create(name: "orangecat", service: "Instagram", uid: "yowl")
      url = "https://api.instagram.com/v1/users/meow/media/recent?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
      HTTParty.stub(:get).with(url) { igs }
      z = InstagramHelper.new
      z.query_for_igs("meow", user.id)
      expect(z.results_array[0][:words]).to eq "orangecat.jpg" # HERE'S A TEST FINALLY!
    end
  end
end
