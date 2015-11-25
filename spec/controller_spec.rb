require 'spec_helper'

describe Garbanzo::Controller do
  describe '#erb' do
    class GarbanzoTestController < Garbanzo::Controller
      template_directory Pathname.pwd + 'spec/fixtures/views'

      def index
        erb :index
      end
    end

    it 'render the template properly' do
      result = GarbanzoTestController.new.method(:index).call
      expect(result).to eq("<h1>it works!</h1>\n")
    end
  end
end
