require 'rubygems'
require 'sinatra/base'
require 'webrick'
require './app'
require File.join(File.dirname(__FILE__), 'app.rb')

run Bookmark
