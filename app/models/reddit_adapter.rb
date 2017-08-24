require 'json'
require 'rest-client'

class RedditAdapter

  attr_accessor :request, :link, :current_subreddit, :page, :count, :last_link

  def request
    # reddit hash from JSON
    @request = JSON.parse(RestClient.get(self.link))
  end

  def initialize
    # initializes on the front page of r/all
    @page = 0
    @current_subreddit = "all"
    self.set_up
  end

  def set_up(ll: nil)
    @count = @page * 25
    @last_link = ll
    @link = "https://www.reddit.com/r/#{@current_subreddit}/.json?count=#{@count}#{@last_link}"
    self.request
  end

  def children
    @request["data"]["children"]
  end

  def last_link
    last_index = self.children.size - 1
    name = self.children[last_index]["data"]["name"]
    @last_link = "&after=#{name}"
  end

end
