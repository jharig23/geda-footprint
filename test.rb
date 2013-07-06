require 'debugger'
load './lib/geda_footprint.rb'

include GedaFootprint



r = Renderer.new

e = Header.new(rows: 10, cols: 3, 
               pitch: Unit('2.54 mm'), 
               pin_diameter: Unit('2 mm'),
               drill_diameter: Unit('1 mm'))
                
r.render(e)
puts r.rendered_element




   


                     
