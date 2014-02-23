require 'rubygems'
require 'sinatra'
require 'instagram'

###Instagram logic
enable :sessions

CALLBACK_URL = "http://localhost:4567/oauth/callback"

Instagram.configure do |config|
  config.client_id = "22473cea5022408e957e567d0d374d3c"
  config.client_secret = "93b68e1a186f4ec1931834e104cc6c60"
end

get "/home" do
  # '<a href="/oauth/connect">Connect with Instagram</a>'
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
  @user_pics = []
  html = "<h1>#{user.username}'s recent photos</h1>"
  for media_item in client.user_recent_media
    @user_pics << media_item.images.low_resolution.url
    html << "<img src='#{media_item.images.low_resolution.url}'>"
  end
  html
  erb :create
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
