require_relative "../tweet.rb"
require_relative "../tweets.rb"
require "fileutils"

describe Twitter::Tweet do

  let(:yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_1.yml", __FILE__) }
  let(:tweets) { Tweets.new.deserialize(yaml_file).tweets }

  describe "#display_tweet" do

    it "should display correctly" do
      #puts tweets.first.class.instance_methods
      #tweets.first.should == ""
      tweets.first.display_string.should == ""
    end

  end

  describe "#deserialize" do
    let(:yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_1.yml", __FILE__) }

    it "should deserialize correctly" do
      Tweets.new.deserialize(yaml_file).tweets.length.should == 20
    end
  end

end
