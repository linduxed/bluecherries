# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bluecherries/version'

Gem::Specification.new do |spec|
  spec.name          = 'bluecherries'
  spec.version       = BlueCherries::VERSION
  spec.authors       = ['linduxed']
  spec.email         = ['linduxed@gmail.com']
  spec.description   = 'Goes through a dictionary of available words and ' \
                       'then ranks these according to how easy they are to ' \
                       'type on a provided keyboard layout. A password is ' \
                       'then generated by combining top ranked words.'
  spec.summary       = 'Generates passwords that are easy to type.'
  spec.homepage      = 'https://github.com/linduxed/bluecherries'
  spec.license       = 'WTFPL'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'rb-inotify'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-doc'
end
