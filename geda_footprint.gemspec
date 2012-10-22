Gem::Specification.new do |s|
  s.name = 'geda_footprint'
  s.version = '0.0.0'
  s.date = '2012-10-20'
  s.summary = 'gEDA Footprint Library'
  s.description = 'Library for creating gEDA PCB footprint files'
  s.authors = ['James Harig']
  s.email = 'jharig23@gmail.com'
  s.files = ["lib/geda_footprint.rb",
             "lib/geda_footprint/attr.rb", 
             "lib/geda_footprint/units.rb",
             "lib/geda_footprint/quoted.rb",
             "lib/geda_footprint/helper.rb",
             "lib/geda_footprint/position.rb",
             "lib/geda_footprint/pcb_element.rb",
             "lib/geda_footprint/element.rb",
             "lib/geda_footprint/pad.rb",
             "lib/geda_footprint/pin.rb",
             "lib/geda_footprint/line.rb",
             "lib/geda_footprint/arc.rb",
             "lib/geda_footprint/pad_line.rb",
             "lib/geda_footprint/quad_package.rb",
             "lib/geda_footprint/renderer.rb"]
  s.homepage = ''
end
