class ResultsWriter
	attr_accessor :matches, :path
	def initialize(path, matches)
		@path = path
		@matches = matches
	end

	def write
		file_name = "results on " + Time.now.to_s + ".html"
		full_path = path + '/' + file_name
		File.open(full_path, 'w') do |f2|  
		  # use "\n" for two lines of text  
		  f2.puts "<html><body>"

		  f2.puts "<h2>hi, there are #{matches.count} matches today</h2> <br/>"

		  @matches.each {|match| 
		  	f2.puts match.to_html
		  }

		  f2.puts "</body></html>"
		end  
	end

end
