# encoding: UTF-8

require 'tweetstream'
require 'yaml'
require 'date'
require 'fileutils'
require 'time'
require_relative 'tweets'
require_relative 'tweet'

class GetTweets

  class NoOauthFileException < Exception; end
  class InvalidOauthFileException < Exception; end

  attr_accessor :display
  attr_writer :tweets, :more_tweets

  def initialize(oauth_file = nil)
    raise_no_oauth_file_exception unless oauth_file && File.exists?(File.expand_path(oauth_file))
    configure_tweetstream(File.expand_path(oauth_file))
    tweets = Tweets.new
  end

  def tweets
    @tweets ||= Tweets.new
  end

  def more_tweets
    @more_tweets ||= nil
  end

  def display_oauth_file_explanation
    puts "You must call #{self.class.name}.new() with the location of your OAuth credentials YAML file"
    puts "The file should look like this (but with valid values):\n"
    puts "---"
    puts "consumer_key: Id254ZAzQJtF7ltUerYPw"
    puts "consumer_secret: fSuNNvlairlesqGDnasde58zib3hApHMTUnZ0J94jmw"
    puts "oauth_token: 938572174-ByY7Plbe1J4Dp5JSwZjmPowBwOr2VVjLA2Juxeqp"
    puts "oauth_token_secret: PrRwQVOgO2Sg0r4IOJPwQq95IqHieZeEnemxkiHKw"
  end

  def raise_no_oauth_file_exception
    display_oauth_file_explanation
    raise NoOauthFileException
  end

  def raise_invalid_oauth_file_exception(msg)
    display_oauth_file_explanation
    raise InvalidOauthFileException, msg
  end

  def get_settings(oauth_file)
    YAML.load_file oauth_file
  rescue
    raise_invalid_oauth_file_exception("Cannot read file as valid YAML file")
  end

  def configure_tweetstream(oauth_file)
    TweetStream.configure do |c|
      settings = get_settings(oauth_file)
      ['consumer_key', 'consumer_secret', 'oauth_token', 'oauth_token_secret'].each do |twitk|
        raise_invalid_oauth_file_exception("#{oauth_file} must have a valid #{twitk} value") unless settings[twitk]
        c.public_send(twitk + '=', settings[twitk])
      end
      c.public_send('auth_method=', :oauth)
    end
  end

  def handle_tweet(tweet)
    tweet.display if display
    if more_tweets
      self.more_tweets = more_tweets - 1
      self.tweets << tweet
      p "Tweets count: " + tweets.size.to_s
    end
  rescue Exception => e
    puts "***Error saving tweet***: #{e.message}\n"
  end

  def sample(num = nil, config = {})
    self.more_tweets = num if num
    self.display = (config[:display] && config[:display] == false) ? false : true
    tsc = TweetStream::Client.new
    tsc.sample do |status, client|
      handle_tweet(status)
      client.stop if more_tweets <= 0
    end
    (sleep 0.2 until more_tweets <= 0) if num
    tweets
  end

  def track_term(term, num = nil, config = {})
    self.more_tweets = num if num
    self.display = config[:display] || true
    tsc = TweetStream::Client.new
    tsc.track(term) do |status, client|
      handle_tweet(status)
      client.stop if more_tweets <= 0
    end
    (sleep 0.2 until more_tweets <= 0) if num
    tweets
  end
end
