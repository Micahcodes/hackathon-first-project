require 'sinatra'
require 'rubygems'
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

helpers do
  def admin?
    session[:admin]
  end
end
get '/public' do
  "This is the public page - everybody is welcome!"
end

get '/private' do
  halt(401,'Not Authorized') unless admin?
  "THis is the private page - members only"
end

get '/login' do
  redirect to("/auth/twitter")
end

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
end

get '/auth/failure' do
  params[:message]
end

get '/logout' do
  session[:admin] = nil
  "You are now logged out"
end

get '/tweet' do
  'https://upload.twitter.com/1/statuses/update_with_media.json'
end
get '/home' do
  erb :homepage
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
