require 'bundler'

Bundler.require

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'db/reddit.db'
  })

# require_all './lib'
require_all './app/models'
