module GedaFootprint
  class QuadPackage < Element
    attr :number_of_pads => 16
    attr :pad_thickness => Unit("0 mm")
    attr :pitch => Unit('0 mm')
    attr :pad_anchor => :middle

    def initialize(hash = {})
      super(hash)

      pads_per_side = self.number_of_pads / 4
      side_length = (pads_per_side - 1) * self.pitch
      border_length = side_length + Unit('0.9 mm')

      border = Rectangle.new(p: Position.new(x: Unit('0 mm'),
                                             y: side_length),
                             width: border_length,
                             height: border_length)

      pad_rect = border.new_centered(width: side_length, height: side_length)

      left = PadLine.new(pad_attributes(p1: pad_rect.top_left, p2: pad_rect.bottom_left,
                                        first_pad_number: (pads_per_side * 0) + 1))

      bottom = PadLine.new(pad_attributes(p1: pad_rect.bottom_left, p2: pad_rect.bottom_right,
                                        first_pad_number: (pads_per_side * 1) + 1))

      right = PadLine.new(pad_attributes(p1: pad_rect.bottom_right, p2: pad_rect.top_right,
                                  first_pad_number: (pads_per_side * 2) + 1))

      top = PadLine.new(pad_attributes(p1: pad_rect.top_right, p2: pad_rect.top_left,
                                        first_pad_number: (pads_per_side * 3) + 1))

      add_child(border)
      add_child(left)
      add_child(bottom)
      add_child(right)
      add_child(top)

    end

    def pad_attributes(hash)
      {
        pad_separation: self.pitch, pad_thickness: self.pad_thickness,
        pad_length: self.pad_length, number_of_pads: self.number_of_pads / 4,
        anchor: self.pad_anchor
      }.merge(hash)
    end



    end


    def pad_line_params(hash)
      result = {}
      [:pad_thickness, :pad_clearance, :pad_mask_width,
       :positive_pad_length, :negative_pad_length,
       :pad_2_pad_distance].each do |param|
        result[param] = send(param)
      end
      result[:number_of_pads] = pads_per_line
      result.merge(hash)
    end

    def pads_per_line
      self.pins / 4
    end

  end
end
