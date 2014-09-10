class TwitterItem < Item
  require 'tweetstream'
  
  def self.print_status
    TweetStream::Client.new.track(Wall.all.map{|x| "#" + x["hashtag"]}) do |tweet|
      
      hashtags = []
      tweet.hashtags.each do |h|
        hashtags << h.text.downcase
      end

      open('/Users/Dora/Desktop/HypeWall/log/probni.txt', 'a') { |f|
        f.puts "#{tweet.media}"
      }
      if tweet.media.present?
     	url = "#{tweet.media[0].media_url}"
     else
     	url = nil
     end
      Wall.where("hashtag IN (?)", hashtags).each do |w|

 
        TwitterItem.create(original_id: tweet.id, user_id: tweet.user.id, url: url, wall_id: w.id, text: tweet.text)
      end
    end
  end
  
end
