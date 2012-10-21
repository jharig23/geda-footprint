require 'rake'

Gem::Specification.new do |s|
  s.name = 'geda_footprint'
  s.version = '0.0.0'
  s.date = '2012-10-20'
  s.summary 'gEDA Footprint Library'
  s.description = 'Library for creating gEDA PCB footprint files'
  s.authors = ['James Harig']
  s.email = 'jharig23@gmail.com'
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
  
  s.homepage = ''

end
