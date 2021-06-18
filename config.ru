# .ru => Rackup file

require 'rack/cors'
require_relative "config/environment.rb"

# utilize the Rack-cors to allow CORS on our server
use Rack::Cors do
  allow do
    origins "*"
    resource '/*', headers: :any, methods: [:get, :post, :delete, :patch, :put, :options]
  end
end

run App.new