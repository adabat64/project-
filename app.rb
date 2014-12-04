
require 'rubygems'
require 'bundler/setup'

Bundler.require
require './models/Income'
require './models/User'
require './models/Expense'
require './models/Budget'

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
    @expense_items  = @user.expenses.order(:from)
    @budget_items =@user.budgets.order(:from)
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

get '/new_transaction' do
  erb :new_transaction
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




post '/new_income' do
  @user.incomes.create(amount_in: params[:money], from: params[:description], received_on: params[:date], tagged_to: params[:tag], grouped_with: params[:group])
  redirect"/"
end

post '/new_expense' do
  @user.expenses.create(amount_exp: params[:exp_money], from: params[:exp_description], received_on: params[:exp_date], tagged_to: params[:exp_tag], grouped_with: params[:exp_group])
  redirect"/"
end

post '/new_budget' do
  @user.budgets.create(amount_bud: params[:bud_money], from: params[:bud_description])
  redirect "/"
end

get '/delete_user' do
  @user.destroy
  redirect '/'
end

get '/delete_expense_item/:exp' do
  @expense = Expense.find(params[:exp])
  @user = @expense.user
  @expense.destroy
  redirect'/'
end

get '/delete_income_item/:inc' do
  @income = Income.find(params[:inc])
  @user = @income.user
  @income.destroy
  redirect '/'
end

get '/delete_budget_item/:bud' do
  @budget = Budget.find(params[:bud])
  @user = @budget.user
  @budget.destroy
  redirect '/'
end
