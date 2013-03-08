# encoding: UTF-8

require 'tweetstream'
require 'yaml'
require 'date'
require 'fileutils'
require 'time'
require 'forwardable'
require_relative 'tweet'

class Tweets

  attr_accessor :tweets

  include Enumerable
  extend Forwardable

  def_delegators :@tweets, :each, :<<, :[], :[]=, :concat, :size, :length, :first, :last

  def initialize(config={})
    @tweets = config[:tweets] || []
  end

  def serialize(save_name)
    File.open(save_name, 'w') do |f|
      f.write YAML.dump(tweets)
    end
  end

  def deserialize(save_name)
    tweets = YAML.load(File.read(save_name))
  end

  def to_array_of_hashes
    # makes each Tweet a simple hash
    # then puts all the hashes into an array
    arr = []
    tweets.each do |tweet|
      arr << tweet.to_hash
    end
    arr
  end

  def to_json
    # formats each Tweet using JSON
    # then returns a JSON array with all the tweets
    json_string = "["
    tweets.each do |tweet|
      json_string += tweet.to_json
      json_string += ','
    end
    json_string.gsub!(/,$/,"]")
  end
end
