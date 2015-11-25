module Garbanzo
  class Router
    attr_reader :compiled_routes
    attr_reader :uncompiled_routes

    def initialize(&block)
      @compiled_routes = {}
      @uncompiled_routes = {}
      instance_eval(&block) if block_given?
    end

    def call(env)
      @env = env
      @verb = @env['REQUEST_METHOD']
      @requested_path = @env['PATH_INFO']

      fetch_controller_action
      if @controller_action
        response = @controller_action.call(@values)
        [200, {}, [response]]
      else
        [404, {}, ["Oops! No route for #{@verb} #{@requested_path}"]]
      end
    end

    def get(path, controller, action)
      route('GET', path, controller, action)
    end

    private

    def fetch_controller_action
      @compiled_routes[@verb].each do |compiled_path, route|
        @values = {} # hash that will contain URL variables

        # Check if regex (compiled earlier) matches the requested URL path
        @match = compiled_path.match(@requested_path)
        if @match
          @controller_action = route['method']

          # Fill in @values above with URL variables
          route['keys'].each_with_index do |value, i|
            @values[value] = @match.captures[i]
          end
        else
          next
        end
      end
    end

    def route(method, path, controller, action)
      # Retrieve controller and action:
      controller_action = controller.new.method(action)
      # Add to uncompiled, human readble routes:
      @uncompiled_routes[method] ||= {}
      @uncompiled_routes[method][path] = controller_action
      # Add to compiled routes:
      compiled_path = Compiler.new.compile_path(path)
      compiled_path_keys = compiled_path[1]
      compiled_path_regex = compiled_path[0]
      @compiled_routes[method] ||= {}
      @compiled_routes[method][compiled_path_regex] = { 'keys' => compiled_path_keys, 'method' => controller_action }
    end
  end
end
