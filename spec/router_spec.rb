require 'spec_helper'

describe Garbanzo::Router do
  class PageController
    def index
      puts 'hi'
    end
  end

  describe '#get' do
    context 'in general' do
      before do
        @router = Garbanzo::Router.new do
          get '/', PageController, :index
        end
      end

      it 'is an instance of Garbanzo::Router' do
        expect(@router).to be_an_instance_of(Garbanzo::Router)
      end
    end

    context 'no parameters' do
      before do
        @router = Garbanzo::Router.new do
          get '/', PageController, :index
        end
      end

      it 'is an instance of Garbanzo::Router' do
        expect(@router).to be_an_instance_of(Garbanzo::Router)
      end

      it 'adds to compiled_routes' do
        @compiled_routes = @router.compiled_routes
        @compiled_route_regex = /\A\/\z/
        @compiled_route = @compiled_routes['GET'][@compiled_route_regex]
        @route_keys = %w(keys method)

        expect(@compiled_routes.size).to eq(1)
        expect(@compiled_routes['GET'].size).to eq(1)
        expect(@compiled_routes['GET'].keys.first).to eq(@compiled_route_regex)
        expect(@compiled_route.keys).to eq(@route_keys)
        expect(@compiled_route['keys']).to eq([])
        expect(@compiled_route['method']).to be_a(Method)
      end

      it 'adds to uncompiled_routes' do
        expect(@router).to be_an_instance_of(Garbanzo::Router)
        expect(@router.uncompiled_routes.size).to eq(1)
        expect(@router.uncompiled_routes['GET'].size).to eq(1)
        expect(@router.uncompiled_routes['GET']['/']).to be_a(Method)
      end
    end

    context 'with parameters' do
      before do
        @router = Garbanzo::Router.new do
          get '/pages/:name', PageController, :index
        end
      end

      it 'is an instance of Garbanzo::Router' do
        expect(@router).to be_an_instance_of(Garbanzo::Router)
      end

      it 'adds to compiled_routes' do
        @compiled_routes = @router.compiled_routes
        @compiled_route_regex = /\A\/pages\/([^\/?#]+)\z/
        @compiled_route = @compiled_routes['GET'][@compiled_route_regex]
        @route_keys = %w(keys method)

        expect(@compiled_routes.size).to eq(1)
        expect(@compiled_routes['GET'].size).to eq(1)
        expect(@compiled_routes['GET'].keys.first).to eq(@compiled_route_regex)
        expect(@compiled_route.keys).to eq(@route_keys)
        expect(@compiled_route['keys']).to eq(['name'])
        expect(@compiled_route['method']).to be_a(Method)
      end

      it 'adds to uncompiled_routes' do
        expect(@router).to be_an_instance_of(Garbanzo::Router)
        expect(@router.uncompiled_routes.size).to eq(1)
        expect(@router.uncompiled_routes['GET'].size).to eq(1)
        expect(@router.uncompiled_routes['GET']['/pages/:name']).to be_a(Method)
      end
    end
  end
end
