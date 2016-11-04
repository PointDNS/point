Gem::Specification.new do |s|
  s.name = 'point'
  s.version = "1.0.1"
  s.platform = Gem::Platform::RUBY
  s.summary = "API client for the PointHQ DNS Hosting System"
  
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.has_rdoc = false

  s.add_dependency('json', '>= 1.1.5')

  s.author = "Cogneto.io"
  s.email = "hello@cogneto.io"
  s.homepage = "https://www.pointhq.com"
end
