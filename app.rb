# app.rb
# this is a simple Sinatra app that will test to make sure that your 
# system is set up for the class correctly

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

get '/' do
	erb :index
end

get '/99bottles' do
  @lyrics = (1..99).to_a.reverse.map {|i| "#{i} bottles of beer on the wall, #{i} bottles of beer. Take one down, pass it around, #{i-1} bottles of beer on the wall."}
  erb :bottles
end