module GedaFootprint

  module Sizes
    SMD_SIZES = { '0603' => {
          :pad_width => Unit('0.9 mm'), 
          :pad_height => Unit('0.8 mm'),
          :pad_separation => Unit('0.9 mm')},
        '0805' => {
          :pad_width => Unit('1.05 mm'), 
          :pad_height => Unit('1.30 mm'),
          :pad_separation => Unit('1.30 mm')},
        '1206' => {
          :pad_width => Unit('1.25 mm'), 
          :pad_height => Unit('1.70 mm'),
          :pad_separation => Unit('2.30 mm')},
        '1812' => {
          :pad_width => Unit('1.25 mm'), 
          :pad_height => Unit('2.30 mm'),
          :pad_separation => Unit('4.80 mm')},
        '2010' => {
          :pad_width => Unit('1.40 mm'), 
          :pad_height => Unit('2.50 mm'),
          :pad_separation => Unit('3.50 mm')},
        '2512' => {
          :pad_width => Unit('2.00 mm'), 
          :pad_height => Unit('3.20 mm'),
          :pad_separation => Unit('4.50 mm')}
      }
    def smd_size(size) 
      SMD_SIZES[size]
    end
  end

  
  class SmdTwoPad < Element
    attr :pad_width => Unit('0 mil')
    attr :pad_height => Unit('0 mil')
    attr :pad_separation => Unit('0 mil')
    
    def initialize(hash = {})
      super(hash)
      width = (self.pad_width * 2) + self.pad_separation + Unit('1.4  mm')
      height = self.pad_height + Unit('1.4 mm')
      # outline
      puts "pad_width = #{self.pad_width}"
      add_child(Rectangle.new(p1: Position.origin,
                              p2: Position.new(x: width,
                                               y: height),
                              thickness: Unit("4 mil")))
      
      
      inner_width = (self.pad_width * 2) + self.pad_separation
      puts "width = #{width}"
      puts "inner width = #{inner_width}"
      pad_x = (width - inner_width) / 2.0
      pad_y = (height / 2)
      
      puts "pad_x = #{(pad_x + (self.pad_height / 2))}"
      
      self.mark_position=Position.new(x: (pad_x + self.pad_width)/2, y: pad_y)
      self.text_position=Position.new(x: (pad_x), y: height + Unit('2 mil'))
      
      
      (1..2).each do |pad_number|
        add_child(Pad.new(p1: Position.new(x: pad_x, y: pad_y),
                          p2: Position.new(x: (pad_x + self.pad_width),
                                           y: pad_y),
                          thickness: self.pad_height,
                          adjust_endpoints: true,
                          number: pad_number))
        
        pad_x += self.pad_width + self.pad_separation
      end
      
    end
  end
end

