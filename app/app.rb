ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'


  get '/' do
    redirect '/links'
  end

  get '/links' do
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
    user = User.create(username: params[:username],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if user.save
      redirect '/links'
    else
      p 'fails'
    end
  end

    helpers do
      # def create
      #   @user = User.new(params[:username])
      #   @user.password = params[:password]
      #   @user.save!
      # end

      def current_user
        @current_user ||= User.get(session[:id])
      end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
