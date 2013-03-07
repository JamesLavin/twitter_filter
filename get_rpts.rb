# encoding: UTF-8

require_relative "get_tweets.rb"

gt = GetTweets.new(File.expand_path('~') + '/.backup_my_tweets')

gt.track_term('NFL')
