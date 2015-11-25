require 'spec_helper'

describe Garbanzo::Command::Init do
  include SpecHelper::Command

  it 'complains if Garbanzo project already exists' do
    Dir.chdir(temporary_directory) do
      Dir.mkdir(temporary_directory + 'testy')

      expect do
        lambda { run_command('init', 'testy') }.call
      end.to raise_error(RuntimeError,
                         'A folder already exists where Garbanzo will create the project.')
    end
  end

  it 'creates a Garbanzo project in current directory' do
    Dir.chdir(temporary_directory) do
      lambda { run_command('init', 'testy') }.call
      app_directory = temporary_directory + 'testy'
      expect(File.exist?(app_directory + 'Gemfile')).to eq(true)
      expect(File.exist?(app_directory + 'Rakefile')).to eq(true)
      expect(File.exist?(app_directory + 'README.md')).to eq(true)
    end
  end

  it 'properly capitalizes project name for README.md' do
    Dir.chdir(temporary_directory) do
      lambda { run_command('init', 'testy') }.call
      app_directory = temporary_directory + 'testy'
      expect(File.exist?(app_directory + 'README.md')).to eq(true)
      expect(File.read(app_directory + 'README.md')).to include('Testy')
    end
  end
end
