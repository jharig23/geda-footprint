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

    # Create a new polar line of the specified    
    def new_centered(length)
      connected_line(self.length / 2, length, 0.degrees, :middle)
    end
    
    def as_pad(hash)
      Pad.new(hash.merge(p1: self.p1, p2: self.p2))
    end
    def pad_line(hash)
      PadLine.new(hash.merge(line: self))
    end
    
    def pin_line(hash, pin_callback = nil)
      PinLine.new(hash.merge(line: self), pin_callback)
    end

    # Create n connected lines, which are equidistant from eachother
    def connected_lines(n, length, theta, anchor)
      positions(n).map do | pos|
        connected_line(pos, length, theta, anchor)
      end
    end

    # Create a line which is connected to the current line
    # Position_or_distance is distance from origin of line, or general position
    # Length is the length of the line
    # Theta is the delta angle between this line and the new one
    # anchor is the anchor point of the new line. :start, :middle, :end
    def connected_line(distance_or_position, length, theta, anchor )
      pos1 = case 
             when (distance_or_position.respond_to?(:x) and distance_or_position.respond_to?(:y))
               distance_or_position
             else
               self.position(distance_or_position)
             end

      pos1 = case anchor
             when :start then pos1
             when :middle then calculate_point(pos1, -(length / 2), self.theta + theta)
             when :end then calculate_point(pos1, -length, self.theta + theta)
             end
      PolarLine.new(p: pos1, theta: (self.theta + theta), length: length)
    end

    # Connect a line to the end of this one
    def connect_line(length, theta, anchor)
      connected_line(self.length, length, theta, anchor = :start)
    end

    # Create n positions which are equidistant from eachother 
    def positions(n)
      distance_offset = if n == 1 
                          Unit('0 mm') 
                        else 
                          self.length / (n - 1) 
                        end
      (0 .. (n-1)).to_a.map { |i| position(i*distance_offset) }
    end
      
        
    # calculate the point on the line, which is the
    # specified distance away from the line origin
    def position(distance)
      calculate_point(self.p1, distance, self.theta)
    end

    # translation direction is relative to current theta
    def translate!(direction_in_rads, distance)
      new_point = calculate_point(self.p1, distance, direction_in_rads + self.theta)
      self.p = new_point
    end

    def bisection_point
      position(self.length / 2)
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
