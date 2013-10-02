lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift(lib_dir) unless $:.include?(lib_dir)
require 'mozu_api/version'
 
Gem::Specification.new do |s|
  s.name              = 'mozu_api'
  s.version           = MozuApi::VERSION
  s.date              = Time.now.strftime("%Y-%m-%d")
  s.summary           = ''
  s.description       = ''
  s.email             = 'carson.reinke@brandlabs.us'
  s.authors           = [ 'Carson Reinke' ]
  s.has_rdoc          = false
  
  s.add_runtime_dependency('activeresource', '>= 3.0.0')
  
  s.require_path = 'lib'
  s.files = %w( Gemfile Rakefile ) + Dir.glob('lib/**/*')
end