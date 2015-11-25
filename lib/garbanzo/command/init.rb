require 'pathname'
require 'tilt'

module Garbanzo
  class Command
    class Init < Command
      self.summary = 'Generate a Garbanzo project for the current directory.'
      self.description = 'Creates a Garbanzo project for the current directory if none currently exists.'
      self.arguments = [
        CLAide::Argument.new(%w(NAME), false)
      ]

      def initialize(argv)
        @name = argv.shift_argument
        @root_path = Pathname.pwd
        super
      end

      def validate!
        super
      end

      def run
        create_garbanzo_project
        puts "Finished generating project #{@name}".green
      end

      private

      def create_garbanzo_project
        templates = {
          'Gemfile.tt' => 'Gemfile',
          'Rakefile.tt' => 'Rakefile',
          'README.md.tt' => 'README.md'
        }

        if Dir.exist?(@root_path + @name)
          fail 'A folder already exists where Garbanzo will create the project.'
        else
          @app_templates_directory = File.dirname(__FILE__)[0...-7] + 'templates/app'
          Dir.mkdir(@name)

          templates.each do |template_file, destination_file|
            template_location = "#{@app_templates_directory}/#{template_file}"
            template_erb_template = Tilt['erb'].new(template_location)
            template_contents = template_erb_template.render(self, name: @name)
            destination_location = Pathname.pwd + @name + destination_file
            File.open(destination_location, 'w') { |f| f << template_contents }
            puts "[✓] Created #{destination_file}".blue
          end
        end
      end
    end
  end
end
