Gem::Specification.new do |s|
  s.name = 'point'
  s.version = "1.0.0"
  s.platform = Gem::Platform::RUBY
  s.summary = "API client for the PointHQ DNS Hosting System"
  
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.has_rdoc = false

  s.add_dependency('json', '>= 1.1.5')

  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://www.pointhq.com"
end
