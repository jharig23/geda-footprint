module GedaFootprint
  # Matrix of pins

  class Header < Element
    # 1 2 3 4
    # 5 6 7 8

    attr :pin_diameter => Unit('0 mm')
    attr :drill_diameter => Unit('0 mm')
    attr :pitch => Unit('0 mm')

    attr :rows => 1
    attr :cols => 2

    def initialize(hash)
      super(hash)
      
      pin_rect = Rectangle.new(width: ((self.cols - 1) * self.pitch),
                                    height: ((self.rows - 1) * self.pitch))

      border_delta = self.drill_diameter + Unit('2.0 mm')
      border = pin_rect.sized(delta_width: border_delta, delta_height: border_delta)
      border.translate!(:bottom_left, Position.origin)
      pin_rect.center_in!(border)
      pin_rect.ladder_lines(self.rows).each_with_index do |line, i|
        pin_line = line.pin_line(first_pin_number: (i * self.cols) + 1,
                                 number_of_pins: self.cols,
                                 pitch: self.pitch,
                                 pin_diameter: self.pin_diameter,
                                 drill_diameter: self.drill_diameter)
        add_child(pin_line)      
      end

      add_child(border)

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
