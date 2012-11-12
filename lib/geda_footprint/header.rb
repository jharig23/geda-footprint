require 'geda_footprints'

class Header < Element
  attr :pitch => Unit('2.54 mm')
  attr :pin_diameter => Unit('1.02 mm')
  attr :pin_hole_dia => Unit('0.8 mm')
  attr :pin_rect => Rectangle.new(width: Unit('2.54 mm'))
  
  
end
