require 'rubygems'
require 'sequel'
require 'parseconfig'

module App
    def self.setup
        path = File.expand_path("../", File.basename(__FILE__)) + "/app.conf"

        # Remove app.conf if any
        unless (File.exists?(path))
            conf = ""
            conf << "[database]\n"
            conf << "host = %s\n" % "localhost"
            conf << "port = %s\n" % "3306"
            conf << "username = %s\n" % "root"
            conf << "password = %s\n" % ""
            conf << "database = %s\n" % "weblog"

            file = File.new(path, 'w')
            file.write(conf)
            file.close
        end
        
        conf = ParseConfig.new(path)
        conf = conf['database']

        # Connect to database
        db = Sequel.mysql2(
            :host => conf['host'],
            :port => conf['port'],
            :user => conf['username'],
            :password => conf['password'],
            :database => conf['database'],
        )
        # Load schemas and evaluate them
        Dir["models/schemas/*.schema.rb"].each do |schema|
            File.open(schema, 'r') {|file|
                structure = file.read
                eval(structure)
            }
        end
    end
end

puts "Setting up the application..."
App.setup
puts "Application setup completed. Enjoy!"
exec("ruby app.rb")
