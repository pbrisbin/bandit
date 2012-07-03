# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bandit/version"

Gem::Specification.new do |s|
  s.name        = "bandit"
  s.version     = Bandit::VERSION
  s.authors     = ["patrick brisbin"]
  s.email       = ["pbrisbin@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.licenses      = ["GPL"]
end
