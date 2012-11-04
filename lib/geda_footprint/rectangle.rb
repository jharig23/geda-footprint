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
      [
       Line.new(p1: top_left, p2: top_right, thickness: self.thickness),
       Line.new(p1: top_right, p2: bottom_right, thickness: self.thickness),
       Line.new(p1: bottom_right, p2: bottom_left, thickness: self.thickness),
       Line.new(p1: bottom_left, p2: top_left, thickness: self.thickness)
      ]

    end

    # create a new rectangle with specified width and height,
    # centered in this one.
    def new_centered(hash)
      inner_width = hash[:width]
      inner_height = hash[:height]

      d_width = self.width - inner_width
      d_height = self.height - inner_height
      
      pos = Position.new(x: (self.p.x + (d_width / 2)), y: self.p.y - (d_height / 2))

      Rectangle.new(hash.merge(p: pos))
    end

    def center_position
      self.p + Position.new(x: (self.width / 2), y: (self.height/2))
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
