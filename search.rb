require 'feedzirra'
require './results_writer'
require './feed_search'
require './twitter_search'
require './search_params'

def write_report(matches, prefix)
  matches.sort! { |x,y| y.published <=> x.published }

  writer = ResultsWriter.new './results', matches, prefix
  writer.write
end

params = SearchParams.new
# params.match_all << 'contract'
# params.match_atleast_one = ['remote', 'telecommute']
params.match_any = [
	'javascript', 
	'node', 
	'ruby', 
	'rails', 
	# 'c#', 
	'angular', 
	'android', 
	'mobile app'
	]

f = TwitterSearch.new params
t_matches = f.get_matches
write_report t_matches, 'twitter'

f = FeedSearch.new params
# f_matches = f.get_matches
# write_report f_matches, 'feed'
