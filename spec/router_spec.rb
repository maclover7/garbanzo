require 'spec_helper'

describe Garbanzo::Router do
  class PagesController
    def index
      puts 'hi'
    end
  end

  describe '#get' do
    it 'adds to hash' do
      @router = Garbanzo::Router.new do
        get '/', PagesController, :index
      end

      expect(@router).to be_an_instance_of(Garbanzo::Router)
      expect(@router.routes.size).to eq(1)
      expect(@router.routes['GET'].size).to eq(1)
    end
  end
end
