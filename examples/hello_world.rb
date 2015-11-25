require 'rubygems'
require 'bundler/setup'
require 'garbanzo'

class PageController
  def index(_params)
    'hi'
  end

  def show(params)
    "name is equal to #{params['name']}"
  end
end

ROUTER = Garbanzo::Router.new do
  get '/pages', PageController, :index
  get '/pages/:name', PageController, :show
end
