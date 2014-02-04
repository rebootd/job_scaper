require 'twitter'
require 'yaml'
require './twitter_entry'
require './search_params'

class TwitterSearch
  attr_accessor :params, :matches, :client

  def initialize(params)
  	@params = params
  	@matches = []
  	yml = YAML.load(File.read('./config.yml'))

  	@client = Twitter::REST::Client.new do |config|
      config.consumer_key        = yml["twitter"]["consumer_key"]
      config.consumer_secret     = yml["twitter"]["consumer_secret"]
      config.access_token        = yml["twitter"]["access_token"]
      config.access_token_secret = yml["twitter"]["access_token_secret"]
    end

  end

  def get_matches

  	client.search("\#jobs", :result_type => "recent").take(1000).each do |tweet|
      # puts tweet.uri
      entry = TwitterEntry.new(tweet, params)
      matches << entry if entry.is_match?

    end

    matches

  end

end