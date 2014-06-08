require 'rubygems'
require 'haml'
require 'rack'

module Weblog
    class Controller
        
        def initialize
            @engine = Haml::Engine
        end

        def load(template)
            File.read(Dir.pwd + "/views/#{template}.haml")
        end

        def render(template, params = {})
            @engine.new(template).render(Object.new, params)
        end
        
        def redirect(target, status = 302)
            res = Rack::Response.new
            
            res.redirect(target, status)
            res.finish
        end
    end
end
