module GedaFootprint
  class QuadPackage < Element
    attr :pins => 28
    attr :pad_thickness => Unit("0.23 mm")
    attr :pad_clearance => Unit("0.23 mm")
    attr :pad_mask_width => Unit("0.23 mm")
    attr :positive_pad_length => Unit("0.40 mm")
    attr :negative_pad_length => Unit("0.10 mm")
    attr :pad_2_pad_distance => Unit("0.45 mm")
    
    attr :width => Unit("4.0 mm")
    attr :height => Unit("4.0 mm")
    
    def initialize(hash = {})
      super(hash)
      assemble
    end
    
    def assemble
      positions = [Position.origin,
                   Position.new(x: zero_mm, y: self.height),
                   Position.new(x: self.width, y: self.height),
                   Position.new(x: self.width, y: zero_mm)]
      (0..3).each do |n|
        p1 = positions[n]
        p2 = positions[(n + 1)%4]
        add_child(PadLine.new(pad_line_params(p1: p1, p2: p2,
                                              first_pad_number: 1 + (pads_per_line * n))))
        add_child(Line.new(p1: p1, p2: p2, thickness: Unit("1 mil")))
      end
      
    end
    
    
    def pad_line_params(hash)
      result = {}
      [:pad_thickness, :pad_clearance, :pad_mask_width,
       :positive_pad_length, :negative_pad_length,
       :pad_2_pad_distance].each do |param|
        result[param] = send(param)
      end
      result[:number_of_pads] = pads_per_line
      result.merge(hash)
    end
    
    def pads_per_line
      self.pins / 4
    end
    
  end
end
