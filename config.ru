require 'rubygems'
require 'bundler'
require "./app"

Bundler.require

run Sinatra::Application
puts "running on http://localhost:3000"
