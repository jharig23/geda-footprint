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
      
      p1 + Position.new(x: (self.length * Math::cos(self.theta)),
                            y: (self.length * Math::sin(self.theta)))
    end
  end

end
