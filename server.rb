require 'sinatra'
require 'rubygems'
require 'omniauth-twitter'

set :bind, '0.0.0.0' #Vagrant fix

use OmniAuth::Builder do
  provider :twitter
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
  "THis is tbe private page - members only"
end

get '/login' do
  redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
  session[:admin] = true
  session[:username] = env['omniauth.auth']['info']['name']
  "<h1>Hi #{session[:username]}!</h1>"
end

get '/auth/failure' do
  params[:message]
end

get '/logout' do
  session[:admin] = nil
  "You are now logged out"
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
