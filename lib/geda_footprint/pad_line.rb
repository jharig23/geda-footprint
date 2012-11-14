# PadLine is a line of pads

module GedaFootprint
  class PadLine < ObjectLine

    attr :first_pad_number => 1
    attr :pad_thickness => Unit("0 mil")
    attr :pad_length => Unit("0 mil")

    
    def initialize(hash)
      super(hash)
    end
    
    
    def generate_objects()
      tangent_lines = connected_lines(self.number_of_things, 
                                      self.pad_length, 90.degrees, 
                                      self.anchor)
      pad_number = self.first_pad_number
      puts "first pad number = #{self.first_pad_number}"
      tangent_lines.each_with_index.map do |line, i|
        number = pad_number
        pad_number = pad_number + 1
        pad = line.as_pad(thickness: self.pad_thickness, number: number, 
                    adjust_endpoints: true)         
        pad
      end
    end
  end
end
