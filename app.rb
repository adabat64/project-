# app.rb
# this is a simple Sinatra app that will test to make sure that your
# system is set up for the class correctly

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require

require './models/Expenses'
require './models/Income'

ActiveRecord::Base.establish_connection(
:adapter  => 'sqlite3',
:database => 'db/development.db',
:encoding => 'utf8'
)


get '/' do
	@exp = Expenses.all.order("date")
	@inc = Income.all.order("date")
	erb :index
end

post '/' do
	Expenses.create(params)
	Income.create(params)
	redirect '/'
end
