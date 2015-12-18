ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  get '/' do
    redirect '/links'
  end

  get '/links' do
    @user = User.get(session[:id])
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tag/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  post '/users' do
    user = User.create(username: params[:username], password: params[:password])
    session[:id] = user.id
    redirect '/links'
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
