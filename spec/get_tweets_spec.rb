# encoding: UTF-8

require_relative "../lib/twitter_filter/get_tweets.rb"
require 'fileutils'
require 'fakefs/spec_helpers'

describe GetTweets do

  describe "#new" do
    include FakeFS::SpecHelpers

    context "non-existent configuration" do

      it "raises a NoOauthFileException" do
      
        expect { GetTweets.new }.to raise_error(GetTweets::NoOauthFileException)

      end

    end

    context "configuration file exists" do

      let(:config_file_path) { File.expand_path("~/get_tweets/config.yml") }

      before do
        FileUtils.mkdir_p config_file_path
      end

      context "but is not YAML" do

        let(:config_file_path) { File.expand_path("~/get_tweets/config.yml") }

        before do
          GetTweets.any_instance.stub(:get_settings).and_return("")
        end

        it "raises an InvalidOauthFileException" do
        
          expect { GetTweets.new(config_file_path) }.to raise_error(GetTweets::InvalidOauthFileException)

        end

      end

      context "but lacks values" do

        let(:oauth_yaml_lacking_values) { "---\n" }

        before do
          GetTweets.any_instance.stub(:get_settings).and_return({}.to_yaml)
        end

        it "raises an InvalidOauthFileException" do
        
          expect { GetTweets.new(config_file_path) }.to raise_error(GetTweets::InvalidOauthFileException)

        end

      end

      context "and is valid" do

        let(:valid_oauth_yaml) { "---\n" +
          "consumer_key: Id254ZAzQJtF7ltUerYPw\n" +
          "consumer_secret: fSuNNvlairlesqGDnasde58zib3hApHMTUnZ0J94jmw\n" +
          "oauth_token: 938572174-ByY7Plbe1J4Dp5JSwZjmPowBwOr2VVjLA2Juxeqp\n" +
          "oauth_token_secret: PrRwQVOgO2Sg0r4IOJPwQq95IqHieZeEnemxkiHKw"}

        before do
          GetTweets.any_instance.stub(:get_settings).and_return(YAML.load(valid_oauth_yaml))
        end

        it "returns a GetTweet object" do
          gt = GetTweets.new(config_file_path)
        end

      end

    end

  end

  describe "#sample" do
  
    let(:gt) { GetTweets.new(File.expand_path("~/.backup_my_tweets")) }

    it "gets and saves the correct number of tweets" do
     
      twenty_tweets = gt.sample(20, {display: false})
      twenty_tweets.tweets.length.should >= 20

    end

  end

  describe "#track_term" do
  
    before do
      let(:gt) { GetTweets.new(File.expand_path("~/.backup_my_tweets")) }
    end

    xit "gets tweets for the term" do
     
      gt.track_term('NFL')

    end

  end

end
