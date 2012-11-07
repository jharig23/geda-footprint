module GedaFootprint
  class Rectangle < PcbElement

    # p is top left
    attr :p => Position.origin
    attr :width => Unit('0 mm')
    attr :height => Unit('0 mm')
    attr :thickness => Unit("4 mil")


    def render_with(renderer)
      generate_lines.each do |line|
        line.render_with(renderer)
      end
    end

    def generate_lines
      ccw_lines.map do |polar_line|
        Line.new(p1: polar_line.p1, p2: polar_line.p2,
                 thickness: self.thickness)
      end
    end

    def ccw_points
      [top_left, bottom_left, bottom_right, top_right]
    end

    def ccw_lines
      points = ccw_points
      (0..3).to_a.map do |i|
        PolarLine.new(p1: points[i], p2: points[(i+1)%4])
      end
    end

    # convert the rect to a pad
    def as_pad(hash)
      Pad.new(hash.merge(p1: PolarLine.new(p1: top_left,
                                           p2: bottom_left).bisection_point,
                         p2: PolarLine.new(p1: top_right,
                                           p2: bottom_right).bisection_point,
                         thickness: self.height))
    end

    def translate!(anchor, to_position)
      if self.respond_to? anchor
        anchor_position = send(anchor)
        delta = to_position - anchor_position
        self.p = self.p + delta
      end
      self
    end

    # center self in the provided rect
    def center_in!(rect)
      translate!(:center, rect.center)
      self
    end

    # create a new rectangle with specified width and height,
    # centered in this one.
    def new_centered(hash)
      rect = Rectangle.new(hash)
      rect.center_in!(self)
    end

    def sized(hash)
      Rectangle.new(p: self.p,
                    width: case
                           when hash[:width] then hash[:width]
                           when hash[:delta_width] then self.width + hash[:delta_width]
                           else self.width
                           end,
                    height: case
                            when hash[:height] then hash[:height]
                            when hash[:delta_height] then self.height + hash[:delta_height]
                            else self.height
                            end)
    end

    def center_position
      self.p + Position.new(x: (self.width / 2), y: (self.height/-2))
    end

    def center
      center_position
    end

    def top_left
      self.p
    end

    def top_right
      p + Position.new(y: Unit('0 mm'), x: self.width)
    end

    def bottom_left
      p + Position.new(y: -self.height)
    end

    def bottom_right
      p + Position.new(x: self.width, y: -self.height)
    end
  end
end
