require 'bundler/gem_tasks'

# RSpec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# Rubocop
require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: [:rubocop, :spec]
