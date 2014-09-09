class TwitterItem < Item
  require 'tweetstream'
  
  def self.print_status
    TweetStream::Client.new.track('#paris', '#london', '#newyork') do |status|
      puts "#{status.text}"
    end
  end
  
end
