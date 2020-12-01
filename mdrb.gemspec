# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mdrb/version'
require 'mdrb/post_message'

Gem::Specification.new do |spec|
  spec.name          = "mdrb"
  spec.version       = MD::VERSION
  spec.authors       = ["Bryan Lim"]
  spec.email         = ["ytbryan@hey.com"]
  spec.summary       = %q{Create and manage markdown}
  spec.description   = %q{ Create and manage markdown}
  spec.homepage      = "https://github.com/ytbryan/mdrb"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.post_install_message = MD::MESSAGE
  spec.required_ruby_version = ">= 2.0.0"
  spec.add_dependency 'file-utils' , '~> 0.1.0'
  spec.add_development_dependency "rspec", "~> 3.9.0"
  # spec.add_dependency 'thor' , '~> 0.19.4'
  # spec.add_development_dependency "bundler", "~> 1.10"
  # spec.add_development_dependency "rake", "~> 10.0"
end
