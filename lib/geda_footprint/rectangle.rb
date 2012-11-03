module GedaFootprint
  class Rectangle < PcbElement

    # p is top left
    attr :p => Position.origin
    attr :width => Unit('0 mm')
    attr :height => Unit('0 mm')
    attr :thickness => Unit("4 mil")


    def render_with(renderer)
      generate_lines.each do |line|
        renderer.render(line)
      end
    end

    def generate_lines
      [
       Line.new(p1: top_left, p2: top_right, thickness: self.thickness),
       Line.new(p1: top_right, p2, bottom_right, thickness: self.thickness),
       Line.new(p1: bottom_right, p2: bottom_left, thickness: self.thickness),
       Line.new(p1: bottom_left, p2: top_left, thickness, self.thickness)
      ]

    end

    # create a new rectangle with specified width and height,
    # centered in this one.
    def new_centered(hash)
      Rectangle.new(hash.merge(p: Position.new(x: (self.width, hash[:width]) / 2,
                                               y: (self.height - ((self.height - hash[:height])/ 2)))))
    end


    def top_left
      self.p
    end

    def top_right
      p + Position.new(x: self.width)
    end

    def bottom_left
      p + Position.new(y: self.heght)
    end

    def bottom_right
      p + Position(x: self.width, y: self.width)
    end
  end
end
