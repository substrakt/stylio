# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stylio/version'

Gem::Specification.new do |spec|
  spec.name          = "stylio"
  spec.version       = Stylio::VERSION
  spec.authors       = ["Substrakt Health"]
  spec.email         = ["max@substrakthealth.com"]

  spec.summary       = %q{An independent living styleguide with simple Rails portability}
  spec.description   = %q{Let designers design with Rails in mind without the complication of having to learn or install Rails}
  spec.homepage      = "http://github.com/substrakt-health/stylio"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << "stylio"
  spec.require_paths = ["lib", "lib/stylio", "bin"]

  spec.add_dependency "sinatra"
  spec.add_dependency "sass"
  spec.add_dependency "sprockets"
  spec.add_dependency "uglifier"
  spec.add_dependency "coffee-script"
  spec.add_dependency "thor"
  spec.add_dependency "thin"
  spec.add_dependency "colorize"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "minitest"
end
