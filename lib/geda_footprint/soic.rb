module GedaFootprint
  # pads are drawn in a counter clockwise position.
  # pin1 is top left
  class Soic < Element
    attr :width => Unit('0 mm')
    attr :height => Unit('0 mm')
    attr :pad_length => Unit('0 mm')
    attr :pad_thickness => Unit('0 mm')
    attr :pad_separation => Unit('0 mm')

    attr :pad_line_separation => Unit('0 mm')
    attr :pad_anchor => :middle
    attr :number_of_pads => 2


    def initialize(hash)
      super(hash)
      build()
    end


    def build
      # this needs to be fixed
      inner_width =  self.pad_line_separation
      inner_height = ((self.number_of_pads / 2) - 1) * self.pad_separation

      self.width = (2 * self.pad_length) + inner_width + Unit('2 mm')
      self.height = inner_height + Unit('2 mm')
      border = Rectangle.new(p: Position.new(x: Unit('0 mm'),
                                             y: self.height),
                             width: self.width,
                             height: self.height)

      self.mark_position = border.center_position

      pad_rect = border.new_centered(width: inner_width,
                                    height: inner_height)

      add_child(border)
      #add_child(pad_rect)
      left = PadLine.new(pad_attrs(p1: pad_rect.top_left,
                                   p2: pad_rect.bottom_left,
                                   first_pad_number: 1,
                                   anchor: self.pad_anchor))

      right = PadLine.new(pad_attrs(p1: pad_rect.bottom_right,
                                    p2: pad_rect.top_right,
                                    first_pad_number: (self.number_of_pads / 2) + 1,
                                    anchor: self.pad_anchor))
      add_child(left)
      add_child(right)

      # add pin 1 designation
      designator = Arc.new(p: border.top_left + Position.new(x: Unit('15 mil'),
                                                             y: Unit('15 mil')*-1),
                           width: Unit('10 mil'),
                           height: Unit('10 mil'),
                           start_angle: 0,
                           delta_angle: 360,
                           thickness: Unit('4 mil'))
      add_child(designator)

    end

    def pad_attrs(hash)
      {pad_thickness: self.pad_thickness,
        pad_length: self.pad_length,
        pad_separation: self.pad_separation,
        number_of_pads: (self.number_of_pads / 2)
      }.merge(hash)

    end

  end
end
