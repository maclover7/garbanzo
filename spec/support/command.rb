module SpecHelper
  def self.temporary_directory
    ROOT + 'tmp'
  end

  module Command
    def argv(*argv)
      CLAide::ARGV.new(argv)
    end

    def command(*argv)
      argv << '--no-ansi'
      Garbanzo::Command.parse(argv)
    end

    def run_command(*args)
      Dir.chdir(SpecHelper.temporary_directory) do
        cmd = command(*args)
        cmd.validate!
        cmd.run
      end
    end
  end
end
