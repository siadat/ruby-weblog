require 'rubygems'
require 'sequel'
require 'parseconfig'

module Weblog
    class Model
        attr_reader :table, :dataset

        def initialize(table)
            # Set the table
            @table = table

            # Read from config
            path = File.expand_path("../", File.basename(__FILE__)) + "/app.conf"
            conf = ParseConfig.new(path)
            conf = conf['database']

            ds = Sequel.mysql2(
                :host => conf['host'],
                :port => conf['port'],
                :user => conf['username'],
                :password => conf['password'],
                :database => conf['database'],
            )

            @dataset = ds[table]
        end
    end
end
