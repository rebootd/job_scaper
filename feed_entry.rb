require './search_params'

class FeedEntry
  attr_accessor :feed_entry, :params

  def initialize(entry, params)
    @feed_entry = entry
    @params = params ||= SearchParams.new
  end

  def is_match?
  	# need to search entry.content and entry.title
  	# puts "checking #{feed_entry.url}"

  	found_all = true
  	params.match_all.each {|word| 
  		# if not found, found_all is false
  		if !(/#{word}/i.match(@feed_entry.content) || /#{word}/i.match(@feed_entry.summary) || /#{word}/i.match(@feed_entry.title))
  			found_all = false
  			break 
  		end
  		
  	}

  	return false if !found_all && params.match_all.count > 0

  	found_atleast_one = false
  	params.match_atleast_one.each {|word| 
  		if (/#{word}/i.match(@feed_entry.content) || /#{word}/i.match(@feed_entry.summary) || /#{word}/i.match(@feed_entry.title))
  			found_atleast_one = true
  			break 
  		end
	}

	return false if !found_atleast_one && params.match_atleast_one.count > 0

  	found_any = false
  	params.match_any.each {|word| 
  		if (/#{word}/i.match(@feed_entry.content) || /#{word}/i.match(@feed_entry.summary) || /#{word}/i.match(@feed_entry.title))
  			found_any = true
  			break 
  		end
  	}

  	found_any
  end

  def to_html
  	"<div> <a target='_blank' href='#{feed_entry.url}'>#{feed_entry.title}</a> </div>"
  end

end
