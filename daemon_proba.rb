#!/usr/bin/env ruby
# encoding: utf-8

ENV["RAILS_ENV"] ||= "production"

root  = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, "config", "environment")

require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

daemon = TweetStream::Daemon.new('tracker', :log_output => true, :monitor => true)
daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
  ActiveRecord::Base.logger = Logger.new(File.open('log/stream.log', 'w+'))
end
daemon.track(Wall.all.map{|x| "#" + x["hashtag"]}) do |tweet|
  open('/Users/Dora/Desktop/HypeWall/log/probni.txt', 'w') { |f|
    f.puts "#{tweet.text}"
  }
  hashtags = []
  tweet.hashtags.each do |h|
    hashtags << h.downcase
  end
  Wall.where("hashtag IN (?)", hashtags).each do |w|
    if tweet.media != []
      url = tweet.media[0].media_url
    else
      url = nil
    end
    TwitterItem.create(original_id: tweet.id, user_id: tweet.user.id, url: url, wall_id: w.id, text: tweet.text)
  end
end