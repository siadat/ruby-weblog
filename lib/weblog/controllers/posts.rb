require_relative 'controller.rb'
require_relative '../models/posts.rb'
require_relative 'errors.rb'

module Weblog
    class PostsController < Controller
        
        def list
            template = load('posts/list')

            posts = Post.new.all.each do |post|
                body = StringIO.new(post[:body])
                body.truncate([body.length, 300].min)
                post[:body] = body.read + "..."
                post
            end
            render(template, :posts => posts)
        end

        def add_new
            template = load('posts/new')

            params = {action: 'new', title: "", body: ""}

            render(template, :params => params)
        end

        def view(id)
            template = load('posts/view')

            posts = Post.new.load(id)

            if posts.empty?
                return ErrorsController.new.raise404
            else
                posts = posts[0]
            end

            render(template, :post => posts)
        end

        def delete(id)
            template = load('posts/delete')

            post = Post.new.load(id)

            if post.empty?
                return ErrorsController.new.raise404
            end

            render(template, :id => id)
        end

        def update(id)
            template = load('posts/new')

            posts = Post.new.load(id)

            if posts.empty?
                return ErrorsController.new.raise404
            else
                posts = posts[0]
            end

            params = {action: 'update', post: posts, title: posts[:title], body: posts[:body]}
            render(template, :params => params)
        end

        def submit(data)
            if not data.has_key?("action")
                return ErrorsController.new.raise404
            end
            
            validate = lambda do |data|
                data.each do |key, value|
                    if key == "title" or key == "body"
                        if value.strip == ''
                            return false
                        end
                    end
                end

                return true
            end

            if data["action"] == "new"
                # validate
                if not validate.call(data)
                    return "/posts/new"
                end

                return Post.new.add(data["title"], data["body"])
            elsif data["action"] == "update"
                if not validate.call(data)
                    return "/posts/#{data["post_id"]}/update"
                end

                return Post.new.update(data["post_id"], data["title"], data["body"])
            elsif data["action"] == "delete"
                Post.new.delete(data["post_id"])

                return "/posts"
            end
        end    

    end
end
