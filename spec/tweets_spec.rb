# encoding: UTF-8

require_relative "../lib/twitter_filter/tweet.rb"
require_relative "../lib/twitter_filter/tweets.rb"
require "fileutils"

describe Tweets do
  let(:in_yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_1.yml", __FILE__) }
  let(:out_yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_6.yml", __FILE__) }

  describe "#new" do

    it "should have no tweets" do
      Tweets.new.tweets.should == []
    end
  end

  describe ".deserialize" do

    it "should deserialize correctly" do
      Tweets.deserialize(in_yaml_file).tweets.length.should == 20
    end
  end

  describe "#serialize" do
  
    it "should serialize correctly" do
      twenty_tweets = Tweets.deserialize(in_yaml_file)
      twenty_tweets.serialize(File.expand_path(out_yaml_file))
      loaded_tweets = Tweets.deserialize(out_yaml_file)
      twenty_tweets.tweets.length.should == loaded_tweets.tweets.length
      twenty_tweets.tweets.first.user.screen_name.should == loaded_tweets.tweets.first.user.screen_name
      twenty_tweets.tweets.last.user.screen_name.should == loaded_tweets.tweets.last.user.screen_name
      twenty_tweets.tweets[12].full_text.should == loaded_tweets.tweets[12].full_text
    end
  end

  describe "#to_json" do

    it "should return the tweets formatted as JSON" do
      # can't test time part of string because time_ago is time-dependent
      tweets = Tweets.deserialize(in_yaml_file)
      tweets.to_json.should match /\A\[/
      tweets.to_json.should match /]\Z/
      tweets.to_json.should include "{\"full_text\":\"RT @yougotmeven: (151618) @jbcerveja teu fc é a+ amei tudo\",\"text\":\"RT @yougotmeven: (151618) @jbcerveja teu fc é a+ amei tudo\",\"source\":\"web\",\"created_at\":\"2013-03-07 13:47:14 -0500\",\"display_time_ago\":\""
      tweets.to_json.should include "\",\"user\":{\"screen_name\":\"jbcerveja\",\"profile_image_url\":\"http://si0.twimg.com/profile_images/3347243926/04b8b10d6e9928c6c9ca083bbb25e339_normal.png\"}}"
    end

  end

end
