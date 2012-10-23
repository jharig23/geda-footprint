require 'geda_footprint'


r = Renderer.new
p = SmdTwoPad.new(width: Unit('2.35 mm'), height: Unit('1.9 mm'),
                  pad_length: Unit('0.7 mm'), pad_height: Unit('1.3 mm'),
                  pad_separation: Unit('1.2mm'))

#r.render(p)
