# encoding: UTF-8

require 'tweetstream'
require 'yaml'
require 'date'
require 'fileutils'
require 'time'
require 'forwardable'

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

end
