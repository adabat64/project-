
require 'rubygems'
require 'bundler/setup'

Bundler.require
require './models/Income'
require './models/User'

enable :sessions
set :session_secret, '85txrIIvTDe0AWPCvbeXuXXpULCWZgpoRo1LqY8YsR9GAbph0jfOHosvtY4QFxi6'

if ENV['DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
  )
end

before do
  @user = User.find_by(name: session[:name])
end

get '/' do
  if @user
    @income_items = @user.incomes.order(:from)
    erb :main_page
  else
    erb :signup
  end
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

post '/login' do

  user = User.find_by(name: params[:name])

  if user.nil?

    @message = "Your username was not found."
    erb :message_page

  elsif user.authenticate(params[:password])

    session[:name] = user.name
    redirect '/'

  else
    @message = "You might have the wrong password."
    erb :message_page
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# Handle the possiblity of errors while creating a new user
post '/new_user' do
  @user = User.create(params)
  if @user.valid?
    session[:name] = @user.name
    redirect '/'
  else
    @message = @user.errors.full_messages.join(', ')
    erb :message_page
  end
end

# because of the before filter, we no longer need to
# include the user id in our urls! We can simply
# reference the global @user variable.
# post '/new_item' do
#   @user.todo_items.create(description: params[:task], due: params[:date])
#   redirect "/"
# end

post '/new_income' do
  @user.incomes.create(amount_in: params[:money], from: params[:description], received_on: params[:date], tagged_to: params[:tag], grouped_with: params[:group])
  redirect"/"
end

get '/delete_user' do
  @user.destroy
  redirect '/'
end

# since task ids are globally unique, we don't even need
# a user id to deleted them
get '/delete_item/:thing1' do
  @income = Income.find(params[:thing1])
  @user = @income.user
  @income.destroy
  redirect "/"
end
