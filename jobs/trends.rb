require 'twitter'

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end
  # Tokyo Prefecture: 1118370
  # client.trends_available.map { |a| {name: a.name, woeid: a.woeid} }
  trends =  client.trends(id= 1118370).map { |tw| { label: tw.name, value: tw.tweet_volume }}
  send_event('trends', { items: trends.each_slice(6).to_a[0] })
end
