ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative './data_mapper_setup'

class Bookmark < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    @links = Link.all
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/' do
    link = Link.new(url: params[:url],
                title: params[:title])
    tag = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect to('/')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
                        password: params[:password])
  session[:user_id] = user.id
  redirect to('/')
  end

  helpers do
   def current_user
     @current_user ||= User.get(session[:user_id])
   end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
