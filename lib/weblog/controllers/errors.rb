require_relative 'controller.rb'

module Weblog
    class ErrorsController < Controller

        def raise404
            template = load('errors/404')
            render(template)
        end

    end
end
