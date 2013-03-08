require File.join(File.dirname(__FILE__), 'lib', 'twitter_filter','version.rb')

spec = Gem::Specification.new do |s|  
  s.name = 'twitter_filter'
  s.author = 'James Lavin'
  s.date = TwitterFilter::DATE
  s.add_development_dependency('rspec')
  s.add_development_dependency('rspec-core')
  s.add_development_dependency('rspec-mocks')
  s.add_development_dependency('rspec-expectations')
  s.add_development_dependency('fakefs')
  s.description = 'lets you find the Tweets you want'
  s.email = 'james@jameslavin.com'
  s.files = Dir['README.markdown','LICENSE.txt','lib/**/*.rb','lib/**/*.yml','spec/**/*']
  s.homepage = "https://github.com/JamesLavin/twitter_filter"
  s.require_paths = ['lib']
  s.bindir = 'bin'
  s.executables = []
  s.summary = 'lets you find the Tweets you want'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = TwitterFilter::VERSION
  s.post_install_message = "I hope you find this gem useful!"
end
