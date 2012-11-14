module GedaFootprint
  # Dual Inline Package 
  # with pins

  class Dip < Element
    attr :pin_diameter => Unit('0 mm')
    attr :drill_diameter => Unit('0 mm')
    attr :pitch => Unit('0 mm')

    attr :pin_rect => nil
    attr :number_of_pins => 2


    def initialize(hash)
      super(hash)
      
      pins_per_side = number_of_pins / 2
      self.pin_rect.height  = (pins_per_side - 1) * pitch

      border_delta = self.drill_diameter + Unit('2.0 mm')
      border = pin_rect.sized(delta_width: border_delta, delta_height: border_delta)
      border.translate!(:bottom_left, Position.origin)
      
      pin_rect.center_in!(border)
      pin_rect.vertical_lines.each_with_index do |polar_line, i|
        pin_line = polar_line.pin_line(first_pin_number: (i * pins_per_side) + 1,
                                       number_of_pins: pins_per_side,
                                       pitch: pitch,
                                       pin_diameter: self.pin_diameter,
                                       drill_diameter: self.drill_diameter)
        add_child(pin_line)
      end

      add_child(border)
      #add_child(pin_rect)
      # add pin 1 designation
      designator = Arc.new(p: border.top_left + Position.new(x: Unit('10 mil'),
                                                             y: Unit('10 mil')*-1),
                           width: Unit('5 mil'),
                           height: Unit('5 mil'),
                           start_angle: 0,
                           delta_angle: 360,
                           thickness: Unit('4 mil'))
      add_child(designator)

    end
  end
end
