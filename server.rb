require 'sinatra'
require 'rubygems'

get '/home' do
  "Hey, this is SplashCard Homepage"
  erb :homepage
end
