require 'feedzirra'
require './feed_entry'
require './search_params'
require './results_writer'

class FeedSearch
  attr_accessor :params, :feed_list, :matches, :params

  def initialize(params)
  	@params = params
  	@matches = []
    @feed_list = [
		# 'https://toprubyjobs.com/jobs.atom',
		'https://weworkremotely.com/categories/2/jobs.rss',
		'https://phoenix.craigslist.org/search/sof?query=%20&s=0&format=rss',
		'https://losangeles.craigslist.org/sof/index.rss',
		'https://sandiego.craigslist.org/sof/index.rss',
		'https://sfbay.craigslist.org/sof/index.rss',
		'https://santabarbara.craigslist.org/sof/index.rss',
		'https://atlanta.craigslist.org/sof/index.rss',
		'https://austin.craigslist.org/sof/index.rss',
		'https://boston.craigslist.org/sof/index.rss',
		# 'https://chicago.craigslist.org/sof/index.rss',
		'https://dallas.craigslist.org/sof/index.rss',
		'https://denver.craigslist.org/sof/index.rss',
		'https://lasvegas.craigslist.org/sof/index.rss',
		'https://miami.craigslist.org/sof/index.rss',
		'https://newyork.craigslist.org/sof/index.rss',
		'https://minneapolis.craigslist.org/sof/index.rss',
		'https://philadelphia.craigslist.org/sof/index.rss',
		'https://portland.craigslist.org/sof/index.rss',
		'https://seattle.craigslist.org/sof/index.rss',
		'https://washingtondc.craigslist.org/sof/index.rss',
		'http://jobmote.com/feed.rss',
		'https://careers.stackoverflow.com/jobs/feed?searchTerm=&allowsremote=True',
		'https://jobs.github.com/positions.atom',
		]
  end  

  def get_matches

	feed_list.each {|link|

		puts ''
		puts "searching '#{link}' "
		
		feed = Feedzirra::Feed.fetch_and_parse(link)

		feed.entries.each {|entry|	  
		  print '.'
		  e = FeedEntry.new(entry, params)
		  matches << e if e.is_match?

		}

	}

	matches

  end

	# puts ''
	# puts "match count: #{matches.count}"
	# puts "\n\n"

	# matches.sort! { |x,y| y.published <=> x.published }

	# writer = ResultsWriter.new './results', matches
	# writer.write

end