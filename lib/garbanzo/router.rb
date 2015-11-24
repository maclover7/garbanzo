module Garbanzo
  class Router
    attr_reader :routes

    def initialize(&block)
      @routes = {}
      instance_eval(&block) if block_given?
    end

    def get(path, controller, action)
      route('GET', path, controller, action)
    end

    private

    def route(method, path, controller, action)
      @routes[method] ||= {}
      @routes[method][path] = controller.new.method(action)
    end
  end
end
