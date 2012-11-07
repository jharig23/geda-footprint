module GedaFootprint
  class QuadPackage < Element
    attr :number_of_pads => 16
    attr :pad_thickness => Unit("0 mm")
    attr :pad_length => Unit('0 mm')
    attr :pitch => Unit('0 mm')
    attr :pad_rect => nil # rect to align pads around
    attr :pad_anchor => :middle
    attr :thermal_pad => nil # rect for thermal pad
    def initialize(hash = {})
      super(hash)
      
      pads_per_side = self.number_of_pads / 4
      side_length = (pads_per_side - 1) * self.pitch

      border_delta = Unit('0.9 mm')
      border = self.pad_rect.sized(delta_width: border_delta,
                                   delta_height: border_delta)
      border.translate!(:bottom_left, Position.origin)
      
      self.pad_rect.center_in!(border)

      add_child(border)
      add_child(pad_rect)
      
      add_child(self.thermal_pad.as_pad(self.number_of_pads + 1)) unless self.thermal_pad.nil?

      pad_rect.ccw_lines.each_with_index do |line, i|
        cline = line.new_centered(side_length)
        add_child(cline.pad_line(pad_separation: self.pitch, 
                                 pad_thickness: self.pad_thickness,
                                 pad_length: self.pad_length, 
                                 number_of_pads: self.number_of_pads / 4,
                                 anchor: self.pad_anchor,
                                 first_pad_number: (pads_per_side * i) + 1))
      end
    end
  end
end
