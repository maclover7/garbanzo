## MISC
require 'garbanzo/version'

## COMMANDS (CLI)
require 'garbanzo/command'

## CONTROLLER
require 'garbanzo/controller'

## ROUTER
require 'garbanzo/router'
require 'garbanzo/router/compiler'

## VIEWS
require 'garbanzo/view'

module Garbanzo
  # Path to the installed gem to load resources (e.g. resign.sh)
  def self.gem_path
    if Gem::Specification.find_all_by_name('garbanzo').any?
      return Gem::Specification.find_by_name('garbanzo').gem_dir
    else
      return './'
    end
  end
end
