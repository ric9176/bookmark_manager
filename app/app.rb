require 'sinatra/base'
require_relative '../lib/link'

class Bookmark < Sinatra::Base
  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:index)
  end

  get '/links/new' do
    erb :form
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    p params
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
