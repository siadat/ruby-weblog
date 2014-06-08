Dir['controllers/*.rb'].each {|file| require_relative file }

module Weblog
    class Router
        def call(env)
            default_status = '200'
            default_headers = {"Content-Type" => "text/html"}

            post_pattern = '^\/posts\/([0-9]+)'
            post_delete_pattern = post_pattern + '\/delete$'
            post_update_pattern = post_pattern + '\/update$'
            post_pattern << '$'

            req = Rack::Request.new(env)

            if req.get?
                case req.path_info
                when '/'
                    [default_status, default_headers, [Weblog::IndexController.new.index]]
                when '/posts'
                    [default_status, default_headers, [Weblog::PostsController.new.list]]
                when '/posts/new'
                    [default_status, default_headers, [Weblog::PostsController.new.add_new]]                
                when Regexp.new(post_pattern)
                    [default_status, default_headers, [Weblog::PostsController.new.view($1)]]
                when Regexp.new(post_delete_pattern)
                    [default_status, default_headers, [Weblog::PostsController.new.delete($1)]]
                when Regexp.new(post_update_pattern)
                    [default_status, default_headers, [Weblog::PostsController.new.update($1)]]
                else
                    ['404', default_headers, [Weblog::ErrorsController.new.raise404]]
                end
            else
                case req.path_info
                when '/posts/action/submit'
                    result = Weblog::PostsController.new.submit(req.POST())
                    
                    res = Rack::Response.new
                    puts result.is_a? String
                    if result.is_a? String
                        res.write("Title and Body are required.")
                        res.redirect(result)
                    else
                        res.write("Post created/updated.")
                        res.redirect("/posts/#{result}")
                    end

                    res.finish
                end
            end

        end
    end
end
