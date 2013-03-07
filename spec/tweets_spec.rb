require_relative "../tweets.rb"
require "fileutils"

describe Tweets do

  describe "#new" do

    it "should have no tweets" do
      Tweets.new.tweets.should == []
    end
  end

  describe "#deserialize" do
    let(:yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_1.yml", __FILE__) }

    it "should deserialize correctly" do
      Tweets.new.deserialize(yaml_file).tweets.length.should == 20
    end
  end

end
