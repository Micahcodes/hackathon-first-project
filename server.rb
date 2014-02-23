require 'rubygems'
<<<<<<< HEAD
require 'omniauth-twitter'
require 'pry'

require_relative 'lib/splash.rb'

set :bind, '0.0.0.0' #Vagrant fix

use OmniAuth::Builder do
  load 'lib/credentials.rb'
  provider :twitter, $twitter_consumer_key, $twitter_consumer_secret
end
configure do
  enable :sessions
end
=======
require 'sinatra'
require 'instagram'
>>>>>>> d6105b78b9a31ca95204d55ae69b82c9f4ddd0f6

###Instagram logic
enable :sessions

<<<<<<< HEAD
get '/private' do
  halt(401,'Not Authorized') unless admin?
  "THis is the private page - members only"
end
=======
CALLBACK_URL = "http://localhost:4567/oauth/callback"
>>>>>>> d6105b78b9a31ca95204d55ae69b82c9f4ddd0f6

Instagram.configure do |config|
  config.client_id = "22473cea5022408e957e567d0d374d3c"
  config.client_secret = "93b68e1a186f4ec1931834e104cc6c60"
end

<<<<<<< HEAD
get '/auth/twitter/callback' do

  load 'lib/credentials.rb'
  session[:admin] = true
  session[:username] = env['omniauth.auth']['info']['name']
  "<h1>Hi #{session[:username]}!</h1>"
  puts env['omniauth.auth']
  @twitter_handle = env['omniauth.auth']['info']['nickname']
  require 'twitter'
  client = Twitter::REST::Client.new do |config|
  config.consumer_key = $twitter_consumer_key
  config.consumer_secret = $twitter_consumer_secret
  config.access_token = $twitter_access_token
  config.access_token_secret = $twitter_access_secret
  end
  #puts client.user_timeline(@twitter_handle)
  @list = client.user_timeline(@twitter_handle)
  @tweet_array = []
  @list.each do |tweet|
    if tweet[:full_text].match(/\A[^@]/)
      @tweet_array.push(tweet[:full_text])

    end
  end
  erb :create_2
=======
get "/home" do
  # '<a href="/oauth/connect">Connect with Instagram</a>'
  erb :homepage
>>>>>>> d6105b78b9a31ca95204d55ae69b82c9f4ddd0f6
end

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/create"
end

<<<<<<< HEAD
get '/tweet' do
  'https://upload.twitter.com/1/statuses/update_with_media.json'
end
get '/home' do
  erb :homepage
=======
get "/create" do
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
  @user_pics = []
  html = "<h1>#{user.username}'s recent photos</h1>"
  for media_item in client.user_recent_media
    @user_pics << media_item.images.low_resolution.url
    html << "<img src='#{media_item.images.low_resolution.url}'>"
  end
  html
  erb :create
>>>>>>> d6105b78b9a31ca95204d55ae69b82c9f4ddd0f6
end

get '/create' do
  erb :create
end

get '/create/2' do
  erb :create_2
end

get '/create/3' do
  erb :create_3
end

get '/create/4' do
  erb :create_final
end
