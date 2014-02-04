class SearchParams
	attr_accessor :match_all, :match_any, :match_atleast_one

  def initialize()
    @match_all ||= []
    @match_any ||= []
    @match_atleast_one ||= []
  end
end
