# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/stackprof/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-stackprof"
  spec.version       = RSpec::StackProf::VERSION
  spec.authors       = ["Devinder Khroad"]
  spec.email         = ["dkhroad@gmail.com"]

  spec.summary       = %q{Profile your RSpec examples using stackprof gem}
  spec.description   = %q{Add profiling hooks to use stackprof gem in a RSpec suit}
  spec.homepage      = "https://github.com/dkhroad/rspec-stackprof"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_runtime_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'stackprof'
end
