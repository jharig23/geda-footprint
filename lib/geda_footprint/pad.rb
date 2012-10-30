module GedaFootprint
  class Pad
    include Helper
    
    attr :p1 => Position.origin, :p2 => Position.origin
    attr :thickness => Unit("0 mil")
    attr :clearance => Unit("0 mil")
    attr :mask_width => Unit("0 mil")
    attr :name => ""
    attr :number => 0
    attr :flags => "square"
    
    
    
    def initialize(hash = {})
      hash.each do |key, value|
        send("#{key}=".to_sym, value) unless key == :adjust_endpoints
      end
      

      adjust_endpoints if hash[:adjust_endpoints]
    end
    
    def render_with(renderer)
      renderer.open_line("Pad")
      renderer << [self.p1, self.p2, self.thickness,
                   self.clearance, self.mask_width, self.name,
                   quoted(self.number), self.flags]
      renderer.close_line("Pad")
    end
    
    private

    # adjust endpoints p1 and p2 such that the initially provided value is actually where the pads end
    # note, thickness is still required.
    def adjust_endpoints
      length = Math.sqrt((self.p2.x - self.p1.x)**2 + (self.p2.y - self.p1.y)**2)
      
      if length > self.thickness
        dp = (p2 - p1).directionalize
        adjustment = self.thickness / 2 
        p1.y += (adjustment * dp.y)
        p2.y += (adjustment * (dp.y * -1))
        p1.x += (adjustment * dp.x)
        p2.x += (adjustment * (dp.x * -1))
      else 
        # need to split pad into 
        num_split = (self.thickness / length).to_f.ceil
        split_thickness = self.thickness / num_split
        dp = p2 - p1
        
        (1..num_split).each do |x|
        end
      end
    end
  end
end
