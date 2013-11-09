require "sinatra/base"
require 'thin'
require './lib/user'
require './lib/request'

class Api < Sinatra::Base
  use Rack::Session::Cookie, :key => 'rack.session', :path => '/', secret: "DSLFJSALDFJLADSFJALSDFJADSLFJADSF"


  puts Api.inspect
  def login_required!
    if session[:dev].nil?
      redirect '/'
    end
  end

  def user
    user = User.new(session[:dev], session[:api])
    return user
  end 

  get '/' do
    erb :login, :layout => false
  end
  
  post '/auth' do
    session[:dev] = params['devkey']
    session[:api] = params['apikey']
    redirect to('/home')
  end
  
  get '/logout' do
    session[:dev] = nil
    session[:api] = nil
    redirect to('/')
  end
  
  get '/home' do
    login_required!
    session[:dev]
    data = "Homepage"
    erb :index
  end

  get '/analytics/status' do
    login_required!
    data = Request.new('get', '/analytics/status', user).call
    erb :index, :locals => {:data => data }
  end 

  get '/analytics/trends' do
    login_required!
    data = Request.new('get', '/analytics/vendor/subscription/trends?account=username&startDate=2013-10-01&endDate=2013-10-31', user).call
    erb :index, :locals => {:data => data }
  end 

  get '/orders/list' do
    login_required!
    data = Request.new('get', '/orders/list', user).call
    erb :index, :locals => {:data => data }
  end 

  get '/quickstats/list' do
    login_required!
    data = Request.new('get', '/quickstats/list', user).call
    erb :index, :locals => {:data => data }
  end

end

