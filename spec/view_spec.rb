require 'spec_helper'

describe Garbanzo::View do
  describe '#erb' do
    it 'render the template properly' do
      template_directory = Pathname.pwd + 'spec/fixtures/views'
      result = Garbanzo::View.new.erb(:index, 'template_directory' => template_directory)
      expect(result).to eq("<h1>it works!</h1>\n")
    end
  end
end
