require_relative 'hello_world'

use Rack::Static, urls: ['/images', '/js', '/css'], root: 'assets'

run ROUTER
