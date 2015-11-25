require 'tilt'

module Garbanzo
  class View
    def erb(template, options = {}, locals = {}, &block)
      render(:erb, template, options, locals, &block)
    end

    private

    def compile_template(engine, data, options, views)
      Tilt::Cache.new.fetch engine, data, options, views do
        template = Tilt[engine]
        fail "Template engine not found: #{engine}" if template.nil?

        case data
        when Symbol
          found = false
          path = options['template_directory'] || nil
          @preferred_extension = engine.to_s

          find_template(views, data, template) do |file|
            path = file # keep the initial path rather than the last one
            found = File.exist?(file)

            if found
              path = file
              break
            end
          end

          template.new(path, 1, options)
        when Proc, String
          fail NotImplementedError, 'Coming soon!'
          # body = data.is_a?(String) ? Proc.new { data } : data
          # path, line = settings.caller_locations.first
          # template.new(path, line.to_i, options, &body)
        else
          fail ArgumentError, "Sorry, don't know how to render #{data.inspect}."
        end
      end
    end

    # Calls the given block for every possible template file in views,
    # named name.ext, where ext is registered on engine.
    def find_template(views, name, engine)
      yield ::File.join(views, "#{name}.#{@preferred_extension}")

      if Tilt.respond_to?(:mappings)
        Tilt.mappings.each do |ext, engines|
          next unless ext != @preferred_extension && engines.include?(engine)
          yield ::File.join(views, "#{name}.#{ext}")
        end
      else
        Tilt.default_mapping.extensions_for(engine).each do |ext|
          yield ::File.join(views, "#{name}.#{ext}") unless ext == @preferred_extension
        end
      end
    end

    def render(engine, data, options = {}, locals = {}, &block)
      scope = options['scope']
      views = options['template_directory'] || './views'

      begin
        @default_layout = false
        template        = compile_template(engine, data, options, views)
        output          = template.render(scope, locals, &block)
      end

      output
    end
  end
end
