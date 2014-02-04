require 'feedzirra'
require './feed_entry'
require './search_params'
require './results_writer'

feed_list = ['https://phoenix.craigslist.org/search/sof?query=%20&s=0&format=rss',
	'https://losangeles.craigslist.org/sof/index.rss',
	'https://sandiego.craigslist.org/sof/index.rss',
	'https://sfbay.craigslist.org/sof/index.rss',
	'https://atlanta.craigslist.org/sof/index.rss',
	'https://austin.craigslist.org/sof/index.rss',
	'https://boston.craigslist.org/sof/index.rss',
	'https://chicago.craigslist.org/sof/index.rss',
	'https://dallas.craigslist.org/sof/index.rss',
	'https://denver.craigslist.org/sof/index.rss',
	'https://lasvegas.craigslist.org/sof/index.rss',
	'https://miami.craigslist.org/sof/index.rss',
	'https://newyork.craigslist.org/sof/index.rss',
	'https://minneapolis.craigslist.org/sof/index.rss',
	'https://philadelphia.craigslist.org/sof/index.rss',
	'https://portland.craigslist.org/sof/index.rss',
	'https://seattle.craigslist.org/sof/index.rss']

matches = []

feed_list.each {|link|

	puts "searching '#{link}' .."
	
	feed = Feedzirra::Feed.fetch_and_parse(link)

	params = SearchParams.new
	params.match_all << 'contract'
	params.match_atleast_one = ['remote', 'telecommute']
	params.match_any = ['javascript', 'node', 'ruby', 'rails', 'c#', 'angular']

	feed.entries.each {|entry|
	  
	  # puts entry.title
	  e = FeedEntry.new(entry, params)
	  matches << e if e.is_match?

	}

}

writer = ResultsWriter.new './results', matches
writer.write
