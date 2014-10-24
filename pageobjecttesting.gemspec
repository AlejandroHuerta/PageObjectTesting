lib = File.expand_path('lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require_relative 'lib//version'

Gem::Specification.new do |s|
  s.name        = 'pageobjecttesting'
  s.version     = PageObjectTesting::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ''
  s.email       = ['']
  s.homepage    = ''
  s.summary     = ''
  s.description = ''

  s.test_files  = s.files.grep(%r(^spec))

  s.files        = `git ls-files`.split($\)
  s.require_path = 'lib'

  s.add_dependency 'watir'
  s.add_dependency 'rautomation'
  s.add_dependency 'graphr'

  s.add_development_dependency 'rspec'
end