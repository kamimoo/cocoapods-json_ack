# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-json_ack/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-json_ack'
  spec.version       = CocoapodsJson_ack::VERSION
  spec.authors       = ['Ryo Kamimura']
  spec.email         = ['arcobaleno7+git@gmail.com']
  spec.description   = %q{A short description of cocoapods-json_ack.}
  spec.summary       = %q{A longer description of cocoapods-json_ack.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-json_ack'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'CFPropertyList', '~> 2.3'
  spec.add_runtime_dependency 'jsonpath', '~> 0.5.8'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
