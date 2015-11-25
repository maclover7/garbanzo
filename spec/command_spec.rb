require 'spec_helper'

describe Garbanzo::Command do
  extend SpecHelper::Command

  it 'displays the current version number with the --version flag' do
    expect(Garbanzo::Command.version).to eq(Garbanzo::VERSION)
  end
end
