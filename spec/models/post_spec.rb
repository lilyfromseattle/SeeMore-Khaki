require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:post) {
    Post.new(
      author_id: 1,
      url_id: 123232,
      timestamp: "2010-11-12 17:30:11",
      words: "Picture Caption"
    )
  }
  describe '.author_id' do
    it 'should have an author_id' do
      expect(post.author_id).to eq(1)
    end
  end

  describe '.timestamp' do
    it 'should have a timestamp in a string' do
      expect(post.timestamp.class).to eq(String)
    end
  end

  describe '.words' do
    it 'should be a string' do
      expect(post.words.class).to eq(String)
    end
  end

end
