require 'sinatra'
require 'rubygems'

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
