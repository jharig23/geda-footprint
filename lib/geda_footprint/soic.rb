module GedaFootprint
  # pads are drawn in a counter clockwise position.
  # pin1 is top left
  class Soic < Element

    attr: width => Unit('0 mm')
    attr: height => Unit('0 mm')

    attr: pad_length => Unit('0 mm')
    attr: pad_width => Unit('0 mm')
    attr: pad_separation => Unit('0 mm')

    attr: pad_line_separation => Unit('0 mm')
    attr: pad_anchor => :middle
    attr: number_of_pads => 2


    def initialize(hash)
      super(hash)
    end

    def build
      add_child(Rectangle.new(p: Position.new(x: Unit('0 mm'), y: self.height),
                              width: self.width,
                              height: self.height))

      # spoof position, we'll correct it after.
      left_pads = PadLine.new(pad_attr(p: Position.origin,
                                       theta: 270.degrees,
                                       first_pad_number: 1))
      right_pads = PadLine.new(pad_attr(p: Position.origin,
                                        theta: 90.degrees,
                                        first_pad_number: (self.number_of_pads / 2) + 1))


      # figure out position for pin 1
      left_pads.p  = Position.new(x: (self.width - self.pad_line_separation) / 2,
                                  y: (self.height - ((self.height - left_pads.length)/2)))
      right_pads.p = Position.new(x: (self.width - ((self.width - self.pad_line_separation) / 2)),
                                  y: (self.height - right_pads.length)/2)

      add_child(left_pads)
      add_child(right_pads)

    end

    def pad_attrs(hash)
      {pad_width: self.pad_width,
        pad_length: self.pad_length,
        pad_separation: self.pad_separation,
        number_of_pads: (self.number_of_pads / 2)
      }.merge(hash)

    end

  end
end
