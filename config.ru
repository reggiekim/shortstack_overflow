require "sinatra/base"
#require "sinatra/reloader"
require "pry"
require "pg"
require_relative "server"

run Sinatra::Server
