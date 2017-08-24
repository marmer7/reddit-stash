class PageInteraction

  attr_accessor :client, :posts

  def initialize
    @client = RedditAdapter.new
  end

  def posts
    @client.children
  end

  def next_page
    @client.page += 1
    @client.set_up(ll: self.client.last_link)
  end

  def previous_page
    if @client.page > 0
      @client.page -= 1
      self.client.set_up(ll: self.client.last_link)
    end
  end

  def change_subreddit(subbreddit)
    @client.page = 0
    @client.current_subreddit = subbreddit
    @client.set_up(ll: nil)
  end

  # def first_post
  #   self.posts[0]["data"]["title"]
  # end
end
