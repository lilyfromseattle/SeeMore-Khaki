require 'rails_helper'

RSpec.describe Author, type: :model do
   let(:author) {
     Author.new(
     service: "Vimeo",
     name: "matthooks",

     )
   }
  describe '.service' do
    it 'has a service' do
      expect(author.service).to eq("Vimeo")
    end
  end

  describe '.name' do
    it 'has a name' do
      expect(author.name).to eq("matthooks")
    end
  end
end
