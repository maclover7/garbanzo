$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'garbanzo'

require 'fileutils'
require 'pathname'
ROOT = Pathname.new(File.expand_path('../../', __FILE__))

Dir[ROOT.join('spec/support/**/*.rb')].each { |f| require f }

def temporary_directory
  SpecHelper.temporary_directory
end

RSpec.configure do |config|
  config.after(:each) do
    FileUtils.rm_rf(temporary_directory + 'testy') if Dir.exist?('tmp/testy')
  end
end
