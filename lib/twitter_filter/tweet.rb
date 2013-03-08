require 'tweetstream'
require 'json'

class Twitter::Tweet

  def display_time_ago
    seconds_ago = Time.now - created_at
    if seconds_ago < 60
      return "less than a minute ago"
    elsif seconds_ago < 60*2
      return "about a minute ago"
    elsif seconds_ago < 60*60
      return "about #{(seconds_ago/60).round} minutes ago"
    elsif seconds_ago < 60*60*2
      return "about an hour ago"
    elsif seconds_ago < 60*60*24
      return "about #{(seconds_ago/(60*60)).round} hours ago"
    else
      return "about #{(seconds_ago/(60*60*24)).round} days ago"
    end
  end

  def display(format="string")
    puts self.send("display_" + format)
  end

  def display_string
    'User: ' + user.screen_name + "\n" +
    'User img: ' + user.profile_image_url + "\n" +
    'Text: ' + full_text + "\n" +
    "from " + source + "\n" +
    created_at.to_s + "\n" +
    display_time_ago + "\n" +
    "#{user.screen_name} [#{created_at.to_s}]: #{text}"
  end
  
  def to_json
    tweet_hash =
      {"full_text" => full_text,
       "text" => text,
       "source" => source,
       "created_at" => created_at.to_s,
       "display_time_ago" => display_time_ago,
       "user" => {"screen_name" => user.screen_name, "profile_image_url" => user.profile_image_url}}
    tweet_hash["in_reply_to_screen_name"] = in_reply_to_screen_name if in_reply_to_screen_name
    tweet_hash.to_json
  end
end
