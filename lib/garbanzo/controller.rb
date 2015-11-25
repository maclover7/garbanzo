module Garbanzo
  class Controller
    def self.template_directory(directory)
      define_method(:template_directory) do
        directory
      end
    end

    def erb(template_name, options = {})
      default_options = { 'scope' => self, 'template_directory' => './views' }
      template_options = options.merge!(default_options)

      if self.respond_to?(:template_directory)
        template_options['template_directory'] = template_directory
      end

      Garbanzo::View.new.erb(template_name, template_options)
    end
  end
end
