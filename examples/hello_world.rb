require 'rubygems'
require 'bundler/setup'
require 'garbanzo'

class ApplicationController < Garbanzo::Controller
end

class PageController < ApplicationController
  def index(_params)
    'hi'
  end

  def show(params)
    @params = params
    erb :show
  end
end

ROUTER = Garbanzo::Router.new do
  get '/pages', PageController, :index
  get '/pages/:name', PageController, :show
end
