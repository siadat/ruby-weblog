# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "weblog/version"

Gem::Specification.new do |s|
    s.name          = "weblog"
    s.version       = "0.0.1"
    s.authors       = ["Pedram Behroozi"]
    s.email         = ["pedrambehroozi@gmail.com"]
    s.homepage      = ""
    s.summary       = "A very simple weblog app."
    s.description   = "Very simple yet unusable weblog application."

    s.rubyforge_project = "weblog"

    s.files         = `git ls-files`.split("\n")
    s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    s.require_paths = ["lib"]
end
