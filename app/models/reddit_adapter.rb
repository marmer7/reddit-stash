require 'json'
require 'rest-client'

class RedditAdapter

  attr_accessor :link, :current_subreddit, :page, :count

  def request
    # reddit hash from JSON
    @request = JSON.parse(RestClient.get(self.link))
  end

  def initialize(page = 0, subreddit = "all")
    @page = page
    @current_subreddit = subreddit
    self.set_up
  end

  def set_up
    binding.pry
    @count = @page * 25
    @link = "https://www.reddit.com/r/#{current_subreddit}/.json?count=#{count}"
    self.request
  end

  def next_page
    @page += 1
    self.set_up
  end

  def last_page
    @page -= 1
    self.set_up
  end

  def change_subreddit(subreddit)
    @current_subreddit = subreddit
    self.set_up
  end

  def posts
    self.request["data"]["children"]
  end

  # title request["data"]["children"][0]["data"]["title"]

end

# class ApiAdapter
#   attr_accessor :link
#   CHARACTERS = []
#
#   def initialize(link = 'http://www.swapi.co/api/people/')
#     @link = link
#     self.page_loop
#   end
#
#   def link_valid?
#     !self.link.nil?
#   end
#
#   def request
#     @request = JSON.parse(RestClient.get(self.link))
#   end
#
#   def page_loop
#     while self.link_valid?
#       CHARACTERS << self.request['results']
#       self.link = request["next"]
#       puts self.link
#     end
#   end
#
#   def character_array
#     CHARACTERS.flatten
#   end
#
# end
