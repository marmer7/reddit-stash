require './config/environment.rb'

puts "Welcome to Terminal Reddit!"

cli = Cli.new

while true
  cli.header
  cli.print_all_posts
  cli.footer
  input = cli.get_input
  cli.input_processor(input)
end
