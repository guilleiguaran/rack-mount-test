require 'rack/mount'

class FooApp
  def self.call(env)
    # The id will be in env['rack.routing_args'][:id]
    [200, {'Content-Type' => 'text/plain'}, [YAML.dump(env)]]
  end
end

FooRouter = Rack::Mount::RouteSet.new do |set|
  set.add_route FooApp, { :request_method => 'GET', :path_info => %r{^/(?<id>[a-z0-9]+)$} }, {}, :foo
end

# In Rails:
# mount FooRouter => '/foo'
# then the route will be '/foo/:id'
run FooRouter
