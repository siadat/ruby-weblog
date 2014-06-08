require 'rack'
require_relative 'routes.rb'

module App
    # Check for installation. If it is not install then we must install
    # the application first.
    if (File.exists?('app.conf'))
        Rack::Handler::WEBrick.run Weblog::Router.new, :Port => 9292
    else
        require_relative 'setup.rb'
        App.setup
    end
end
