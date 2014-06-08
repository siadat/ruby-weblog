require 'rubygems'
require 'sequel'

module App
    def self.setup
        path = File.expand_path("../", File.basename(__FILE__)) + "/app.conf"

        # Remove app.conf if any
        if (File.exists?(path))
            File.delete(path)
        end

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

        # Connect to database
        db = Sequel.mysql2(
            :host => "localhost",
            :port => "3306",
            :user => "root",
            :password => "",
            :database => "weblog"
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
