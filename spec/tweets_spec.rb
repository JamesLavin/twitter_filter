require_relative "../lib/twitter_filter/tweets.rb"
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

  describe "#serialize" do
    let(:in_yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_1.yml", __FILE__) }
    let(:out_yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_6.yml", __FILE__) }
  
    it "should serialize correctly" do
      twenty_tweets = Tweets.new.deserialize(in_yaml_file)
      twenty_tweets.serialize(File.expand_path(out_yaml_file))
      loaded_tweets = Tweets.new.deserialize(out_yaml_file)
      twenty_tweets.length.should == loaded_tweets.length
      twenty_tweets.first.user.screen_name.should == loaded_tweets.first.user.screen_name
      twenty_tweets.last.user.screen_name.should == loaded_tweets.last.user.screen_name
      twenty_tweets[12].full_text.should == loaded_tweets[12].full_text
    end
  end

end
