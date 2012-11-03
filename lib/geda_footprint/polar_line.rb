# Polar line is a line implementation which is stored in a
# combination of cartesian and polar coordinates
module GedaFootprint

  class PolarLine < PcbElement
    attr :p => Position.origin
    attr :theta => 0.0
    attr :length => Unit('0 mm')

    def initialize(hash = {})
      super(hash)

      digest_line(hash[:line]) if hash.has_key? :line
      digest_line_from_points(hash[:p1], hash[:p2]) if hash.has_key? :p1
    end


    def p1
      self.p
    end

    def p2
      position(self.length)
    end


    # Create n connected lines, which are equidistant from eachother
    def connected_lines(n, length, theta, anchor)
      distance_offset = self.length / (n - 1)
      (0 .. (n-1)).to_a.map do |i|
        connected_line(i*distance_offset, length, theta, anchor)
      end
    end

    # Create a line which is connected to the current line
    # Position is distance from origin of line
    # Length is the length of the line
    # Theta is the delta angle between this line and the new one
    # anchor is the anchor point of the new line. :start, :middle, :end
    def connected_line(distance, length, theta, anchor )
      pos1 = self.position(distance)
      pos1 = case anchor
             when :start then pos1
             when :middle then calculate_point(pos1, -(length / 2), theta)
             when :end then calculate_point(pos1, -length, theta)
             end
      PolarLine.new(p: pos1, theta: theta, length: length)
    end

    # Connect a line to the end of this one
    def connect_line(length, theta, anchor)
      connected_line(self.length, length, theta, anchor = :start)
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

    def to_s
      "PolarLine[p1=#{p1}, p2=#{p2}]"
    end

    private
    def calculate_point(start_position, distance, theta)
      start_position + Position.new(x: (distance * Math::cos(theta)),
                                    y: (distance * Math::sin(theta)))
    end


    def digest_line(line)
      if line.respond_to? :p
        self.p = line.p
        self.theta = line.theta
        self.length = line.length
      elsif line.respond_to? :p1
        digest_line_from_points(p1, p2)
      end
    end

    def digest_line_from_points(p1, p2)
      d = p2 - p1
      self.p = p1
      self.theta = Math.atan2(d.y, d.x)
      self.length = Math.sqrt(d.x**2 + d.y**2)
    end

  end

end
