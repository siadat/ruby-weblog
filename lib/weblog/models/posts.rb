require 'rubygems'
require 'sequel'
require_relative 'model.rb'

module Weblog
    class Post < Model
        attr_reader :table, :dataset

        def initialize
            super(:posts)
        end

        def all
            @dataset.all
        end

        def load(id)
            post = @dataset.where(:id => id).all
            post.dup
        end

        def add(title, body)
            @dataset.insert(:title => title, :body => body)
        end

        def update(id, title, body)
#            @dataset.where(:id => id)
            @dataset.where(:id => id).update(:title => title, :body => body)

            return id.to_i
        end

        def delete(id)
            @dataset.where(:id => id).delete

            return id.to_i
        end
    end
end
