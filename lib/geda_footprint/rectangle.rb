module GedaFootprint
  class Rectangle < PcbElement
    attr :p1 => Position.origin, :p2 => Position.origin
    attr :thickness => Unit("4 mil")

    def initialize(hash)

      if hash.includes? :p
        # p implies width/height
        self.p1 = hash[:p]
        self.p2 = p1 + Point.new(x: hash[:width], y: hash[:height])
      end
    end

    def render_with(renderer)
      generate_lines.each do |line|
        renderer.render(line)
      end
    end

    def generate_lines
      lines = []

      top_left = self.p1
      bottom_right = self.p2

      top_right = Position.new(x: bottom_right.x, y: top_left.y)
      bottom_left =  Position.new(x: top_left.x, y: bottom_right.y)

      lines << Line.new(p1: top_left,
                        p2: top_right, thickness: self.thickness)
      lines << Line.new(p1: top_right,
                        p2: bottom_right, thickness: self.thickness)
      lines << Line.new(p1: bottom_right,
                        p2: bottom_left, thickness: self.thickness)
      lines << Line.new(p1: bottom_left,
                        p2: top_left, thickness: self.thickness)
      lines
    end

  end
end
