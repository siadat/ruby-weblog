require_relative 'controller.rb'

module Weblog
    class IndexController < Controller       

        def index
          template = load('index')
          @engine.new(template).render
        end

    end
end

            
