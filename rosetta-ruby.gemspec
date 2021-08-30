# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'rosetta-ruby'
  spec.version     = '0.0.0'
  spec.summary     = 'Rosetta'
  spec.description = 'Simple Markdown to HTML transformation.'
  spec.authors     = ['Matt Craig']
  spec.email       = 'mattcraig365@gmail.com'
  spec.files       = `git ls-files`.split("\n")
  spec.homepage    = 'https://rubygems.org/gems/rosetta-ruby'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  # spec.add_development_dependency ['rspec', 'byebug']
end
