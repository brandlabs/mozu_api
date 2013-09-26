lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift(lib_dir) unless $:.include?(lib_dir)

require 'bundler'
require 'thor/rake_compat'
require 'mozu_api/version'
require 'rake/testtask'

class Default < Thor
  include Thor::RakeCompat
  
  desc "build", "Build mozu_api-#{MozuApi::VERSION}.gem into the pkg directory"
  def build
    Rake::Task["build"].execute
  end

  desc "install", "Build and install thor-#{MozuApi::VERSION}.gem into system gems"
  def install
    Rake::Task["install"].execute
  end
  
    Rake::TestTask.new() do |test|
      test.libs << 'lib' << 'test'
      test.pattern = 'test/**/*_test.rb'
      test.verbose = true
    end
  
#  desc "test", ""
#  def test
#puts Rake::TestTask.new(:test).inspect
#    Rake::TestTask.new(:test) do |test|
#      test.libs << 'lib' << 'test'
#      test.pattern = 'test/**/*_test.rb'
#      test.verbose = true
#    end.execute()
#  end
end