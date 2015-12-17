require 'data_mapper'
require 'dm-postgres-adapter'

require_relative '../lib/tag.rb'
require_relative '../lib/link.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
