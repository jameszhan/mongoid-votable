# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/votable/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-votable"
  spec.version       = Mongoid::Votable::VERSION
  spec.authors       = ["James Zhan"]
  spec.email         = ["zhiqiangzhan@gmail.com"]
  spec.description   = %q{Votable for Mongoid}
  spec.summary       = %q{Votable for mongoid}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("mongoid",  [">= 3.0.0"])
  spec.add_dependency("activesupport", [">= 3.0.0"])

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  
end
