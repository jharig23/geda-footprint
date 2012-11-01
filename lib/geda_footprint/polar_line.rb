# Polar line is a line implementation which is stored in a
# combination of cartesian and polar coordinates
module GedaFootprint

  class PolarLine < PcbElement
    attr :p => Position.origin
    attr :theta => 0.0
    attr :length => Unit('0 mm')

    def initialize(hash = {})
      super(hash)
      # assume p/theta/length style unless
      # p1/p2 is provided
      if hash.has_key? :p1
        d = hash[:p2] - hash[:p1]
        self.p = hash[:p1]
        self.theta = Math.atan2(d.y, d.x)
        self.length = Math.sqrt(d.x**2 + d.y**2)
      end
    end

    def p1
      self.p
    end

    def p2
      position(self.length)
    end


    # Create a line which is connected to the current line 
    # Position is distance from origin of line
    # Length is the length of the line
    # Theta is the delta angle between this line and the new one
    # anchor is the anchor point of the new line. :start, :middle, :end
    def connected_line(distance, length, theta, anchor )
      pos1 = self.position(distance)
      pos1 = case anchor
             when :start pos1
             when :middle calculate_point(pos1, -(length / 2), theta)
             when :end calculate_point(pos1, -length, theta)
             end
      PolarLine.new(p: pos1, theta: theta, length: length)
    end

    # calculate the point on the line, which is the 
    # specified distance away from the line origin
    def position(distance)
      calculate_point(self.p1, distance, self.theta)
    end
    # translation direction is relative to current theta
    def translate!(direction_in_rads, distance)
      self.p = PolarLine.new(p: self.p, theta: (direction_in_rads + self.theta), length: distance).p2
    end

    private 
    def calculate_point(start_position, distance, theta)
      start_position + Position.new(x: (distance * Math::cos(theta)),
                                    y: (distance * Math::sin(theta)))
    end
  end

end
