require 'claide'
require 'colored'

module Garbanzo
  class Command < CLAide::Command
    require 'garbanzo/command/init'

    self.abstract_command = true
    self.command = 'garbanzo'
    self.version = VERSION
    self.description = 'A fun Ruby MVC framework.'
    self.plugin_prefixes = %w(claide garbanzo)

    def self.options
      [
      ].concat(super)
    end

    def self.run(argv)
      super(argv)
    end
  end
end
