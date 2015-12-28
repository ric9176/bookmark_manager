require 'rubygems'
require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'lib/bookmark.rb')

run Bookmark
