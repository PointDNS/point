Dir[File.join(File.dirname(__FILE__), 'tests', '*.rb')].each do |file|
  require file
end
