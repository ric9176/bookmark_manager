ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative '../lib/link.rb'

class Bookmark < Sinatra::Base
  get '/' do
    @links = Link.all
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/' do
    Link.create(url: params[:url], title: params[:title])
    redirect to('/')
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
