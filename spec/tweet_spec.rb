require_relative "../lib/twitter_filter/tweet.rb"
require_relative "../lib/twitter_filter/tweets.rb"
require "fileutils"

describe Twitter::Tweet do

  let(:yaml_file) { File.expand_path("../../fixtures/tweets/twenty_tweets_1.yml", __FILE__) }
  let(:tweets) { Tweets.new.deserialize(yaml_file).tweets }

  describe "#display_string" do

    it "should display correctly" do
      tweets.first.display_string.should == "User: bixychick\nUser img: http://si0.twimg.com/profile_images/2966510754/b784ea6be31b4e6ba7cc7eb4c52218e8_normal.jpeg\nText: @Great_Big_Sea @alanthomasdoyle @greatbigsean @bobhallett 1st show 11 yrs ago, good times, I'd do it all again. Thx http://t.co/stNcCt1zco\nfrom <a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>\n2013-03-07 13:47:13 -0500\nabout 19 hours ago\nbixychick [2013-03-07 13:47:13 -0500]: @Great_Big_Sea @alanthomasdoyle @greatbigsean @bobhallett 1st show 11 yrs ago, good times, I'd do it all again. Thx http://t.co/stNcCt1zco"
    end

  end

end
