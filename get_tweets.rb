# encoding: UTF-8

require 'tweetstream'
require 'yaml'
require 'json'
require 'date'
require 'fileutils'
require 'time'
require_relative 'tweets'

class GetTweets

  class NoOauthFileException < Exception; end
  class InvalidOauthFileException < Exception; end

  attr_writer :tweets

  def initialize(oauth_file = nil)
    raise_no_oauth_file_exception unless oauth_file && File.exists?(oauth_file)
    configure_tweetstream(oauth_file)
  end

  def tweets
    @tweets ||= Tweets.new
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

  def latest(num = nil)
    TweetStream::Client.new.sample do |status|
      begin
        display_tweet(status)
        if num
          num -= 1
          tweets << status
          return tweets if num == 0
        end
      rescue Exception => e
        puts "\n***Error saving tweet***: #{e.message}\n"
      end
    end
  end

  def track_term(term)
    TweetStream::Client.new.track(term) do |status|
      begin
        display_tweet(status)
      rescue Exception => e
        puts "\n***Error saving tweet***: #{e.message}\n"
      end
    end
  end

  def display_time_ago(seconds)
    if seconds < 60
      return "less than a minute ago"
    elsif seconds < 60*2
      return "about a minute ago"
    elsif seconds < 60*60
      return "about #{(seconds/60).round} minutes ago"
    elsif seconds < 60*60*2
      return "about an hour ago"
    elsif seconds < 60*60*24
      return "about #{(seconds/(60*60)).round} hours ago"
    else
      return "about #{(seconds/(60*60*24)).round} days ago"
    end
  end

  def display_tweet(status)
    puts status.user.screen_name
    puts status.full_text
    puts status.user.profile_image_url
    puts "from " + status.source
    puts status.created_at
    seconds_ago = Time.now - status.created_at
    puts display_time_ago(seconds_ago)
    #puts (Time.now - DateTime.parse(status.created_at).to_time).to_s + ' seconds ago'
    puts "#{status.user.screen_name} [#{status.created_at}]: #{status.text}"
  end
  
end
