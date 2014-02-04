require './search_params'

class TwitterEntry
  attr_accessor :entry, :params

  def initialize(entry, params)
    @entry = entry
    @params = params ||= SearchParams.new
  end

  def published
  	Time.now
  end

  def is_match?
    found_any = false
    params.match_any.each {|word| 
      if /#{word}/i.match(entry.text)
        found_any = true
        break 
      end
    }
    found_any
  end

  def to_html
  	"<li> 
  	<a target='_blank' href='#{entry.uri}'>#{entry.text}</a> 
  	</li>"
  end

end
