class Post

  attr_accessor :post, :post_data

  def initialize(post)
    @post = post
    @post_data = post["data"]
  end

  def post_info_hash
    {
      title: @post_data["title"],
      score: @post_data["score"],
      subreddit: @post_data["subreddit"],
      post_hint: @post_data["post_hint"],
      permalink: @post_data["permalink"],
      created_utc: @post_data["created_utc"]
      # url: @post_data["url"]
    }
  end

end
