module GedaFootprint
  # pads are drawn in a counter clockwise position.
  # pin1 is top left
  class Soic < Element
    attr :pad_length => Unit('0 mm')
    attr :pad_thickness => Unit('0 mm')
    attr :pitch => Unit('0 mm')

    attr :pad_rect => nil
    attr :pad_anchor => :middle
    attr :number_of_pads => 2


    def initialize(hash)
      super(hash)
      pads_per_side = number_of_pads / 2
      self.pad_rect.height  = (pads_per_side - 1) * pitch

      border_delta = Unit('1.0 mm')
      border = pad_rect.sized(delta_width: border_delta, delta_height: border_delta)
      border.translate!(:bottom_left, Position.origin)
      
      pad_rect.center_in!(border)
      pad_rect.vertical_lines.each_with_index do |polar_line, i|
        pad_line = polar_line.pad_line(first_pad_number: (i * pads_per_side) - 1,
                                       number_of_pads: pads_per_side,
                                       pitch: pitch,
                                       pad_thickness: pad_thickness,
                                       pad_length: pad_length,
                                       anchor: pad_anchor)
        add_child(pad_line)
      end

      add_child(border)
      #add_child(pad_rect)
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

    def pad_attrs(hash)
      {pad_thickness: self.pad_thickness,
        pad_length: self.pad_length,
        pad_separation: self.pad_separation,
        number_of_pads: (self.number_of_pads / 2)
      }.merge(hash)

    end

  end
end
