require 'rubygems'
require 'omniauth-twitter'
require 'pry'
require 'sinatra'
require 'instagram'
require_relative 'lib/splash.rb'

set :bind, '0.0.0.0' #Vagrant fix
enable :sessions


######  Instagram logic  ######

CALLBACK_URL = "http://localhost:4567/oauth/callback"

Instagram.configure do |config|
  config.client_id = "22473cea5022408e957e567d0d374d3c"
  config.client_secret = "93b68e1a186f4ec1931834e104cc6c60"
end

get "/home" do
  erb :homepage
end

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/create"
end

get "/create" do
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
  counter = 0
  session[:user_pics] = []

  while counter < 10
    for media_item in client.user_recent_media
      session[:user_pics] << media_item.images.standard_resolution.url
      counter += 1
    end
  end

  @user_pics = session[:user_pics]

  erb :create
end

get '/create/2' do
  erb :create_2
end

post '/create/2' do
  @recipient = params[:recipient]
  @message = params[:message]
  erb :create_3
end

get '/create/3/:pic' do
  @pic = params[:pic]
  @user_pics = session[:user_pics]

  puts @user_pics[0]
  puts @selected

  @selected = @user_pics[@pic.to_i]

  erb :create_3
end

get '/create/4' do
  erb :create_final
end



###### Twitter ######

# get '/private' do
#   halt(401,'Not Authorized') unless admin?
#   "THis is the private page - members only"
# end

# get '/auth/twitter/callback' do

#   load 'lib/credentials.rb'
#   session[:admin] = true
#   session[:username] = env['omniauth.auth']['info']['name']
#   "<h1>Hi #{session[:username]}!</h1>"
#   puts env['omniauth.auth']
#   @twitter_handle = env['omniauth.auth']['info']['nickname']
#   require 'twitter'
#   client = Twitter::REST::Client.new do |config|
#   config.consumer_key = $twitter_consumer_key
#   config.consumer_secret = $twitter_consumer_secret
#   config.access_token = $twitter_access_token
#   config.access_token_secret = $twitter_access_secret
#   end
#   #puts client.user_timeline(@twitter_handle)
#   @list = client.user_timeline(@twitter_handle)
#   @tweet_array = []
#   @list.each do |tweet|
#     if tweet[:full_text].match(/\A[^@]/)
#       @tweet_array.push(tweet[:full_text])
#     end
#   end
#   erb :create_2
# end

# use OmniAuth::Builder do
#   load 'lib/credentials.rb'
#   provider :twitter, $twitter_consumer_key, $twitter_consumer_secret
# end

# get '/tweet' do
#   'https://upload.twitter.com/1/statuses/update_with_media.json'
# end
