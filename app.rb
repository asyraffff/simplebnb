require 'sinatra/base'
require 'sinatra/reloader'

require './database_connection_setup'
require './lib/booking'
require './lib/db_connection'
require './lib/space'
require './lib/user'


class SimpleBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # set :method_override, true

  before do
    @user = User.current
    @space = Space.current
    @spaces = Space.all
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  get '/logout' do
    @user.logout
    redirect '/'
  end

  get '/login' do
    erb :login 
  end

  get '/spaces' do
    if User.current
      @user_owned_spaces = Space.of_user(User.current.id)
      @user_bookings = Booking.by_user(User.current.id)
    end
    erb :'spaces/index'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/create' do
    Space.create(params[:name], params[:description],
      params[:price], User.current.id)
    
    redirect '/spaces'
  end
 
  post '/authenticate' do
    User.authenticate(params[:email], params[:password])

    redirect '/spaces'
  end

  post '/user/create' do
    User.create(params[:name], params[:email], params[:password])

    redirect '/spaces'
  end

  get '/booking/new/:space_id' do
    @space = Space.with_id(:space_id)

    erb :'booking/new'
  end

  post '/booking/create/:space_id' do
    Booking.create(params[:checkin], params[:checkout],
      params[:space_id], User.current.id)

    redirect '/spaces'
  end

  run! if app_file == $0
end