require 'time'

class Cli

  attr_accessor :interface, :permalinks


  def initialize
    @permalinks = []
    @interface = PageInteraction.new
  end

  def header
    puts Rainbow("Reddit - ").color(:red) + Rainbow("#{@interface.client.current_subreddit}").color(:red).background(:white)
  end

  def post_print(post_hash, index)
    @permalinks << post_hash[:permalink]
    #print hash contents
    index = "#{index+1}. "
    score = post_hash[:score]
    align = " "*12
    buffer = " "*(12 - (index.to_s.size + score.to_s.size))
    title = post_hash[:title]
    subreddit = post_hash[:subreddit]
    # post_hint = post_hash[:post_hint]
    # created_utc = post_hash[:created_utc]
    # post_time = t_hour - Time(created_utc).hour
    puts "---"
    print Rainbow(index)
    print Rainbow(score).color(:green)
    print buffer
    if title.size > 64
      puts Rainbow(title.slice(0...64)).bright.underline
      puts align + Rainbow(title.slice(64..127)).bright.underline
    else
      puts Rainbow(title).bright.underline
    end
    puts align + Rainbow(subreddit).bright.magenta
  end

  def footer
    align = " "*12
    puts align+Rainbow("<- previous page (p)" + (" "*27) + "next page (n) -->").background(:white).color(:black)
    puts align+Rainbow((" "*16)+"Change to different subreddit(c)"+(" "*16)).background(:white).color(:black)
    puts align+Rainbow("  ENTER SINGLE OR MULTIPLE NUMBERS SEPARATED BY COMMAS TO OPEN  ").background(:white).color(:black)
  end

  def print_all_posts
    @interface.posts.each_with_index {|post, index| self.post_print(Post.new(post).post_info_hash, index)}
  end

  def get_input
    puts "Please enter an input"
    gets.chomp
  end

  def input_processor(input)
    if input === "n"
      @interface.next_page
      self.reset
    elsif input === "p"
      @interface.previous_page
      self.reset
    elsif input === "c"
      puts "Please enter a valid subreddit: "
      subreddit = gets.chomp
      @interface.change_subreddit(subreddit)
      self.reset
    elsif input.delete(" ").split(",")[0].class === "Fixnum"
      self.open_url(input)
    else
      self.get_input
    end
  end

  def open_url(num_string)
    num_string.delete(" ").split(",").each do |i|
      url_launcher(permalinks[i.to_i-1])
    end
  end

  def url_launcher(url)
    Launchy.open("https://www.reddit.com#{url}")
  end

  def reset
    @permalinks = []
  end

end
