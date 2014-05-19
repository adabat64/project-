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

# Sneaky template stuff: http://www.sinatrarb.com/intro.html#Inline%20Templates
__END__

@@ index
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Sinatra Hello World</title>
  <style>
  body {
  	text-align: center;
  	font-family: Tahoma, Geneva, sans-serif;
  }
  </style>
</head>
<body>
  <h1>Hello, World!</h1>
  <p>If you're seeing this, it means that you've got git, ruby, bundler, and sqlite working properly. Nice job!</p>
  <p>Here is some example dynamic content: <em><%= Time.now.to_s %></em></p>
</body>
</html>