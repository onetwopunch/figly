# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'figly/version'

Gem::Specification.new do |spec|
  spec.name          = "figly"
  spec.version       = Figly::VERSION
  spec.authors       = ["Ryan Canty"]
  spec.email         = ["jrcanty@gmail.com"]
  spec.summary       = %q{A tiny gem that allows you to access config settings from YAML}
  spec.description   = %q{If you ever wanted to access a config Hash using the dot operator, this is the gem for you.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
