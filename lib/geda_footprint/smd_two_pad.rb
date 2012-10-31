module GedaFootprint
  SMD_SIZES = { '0603' => {
      :pad_width => Unit('0.9 mm'),
      :pad_height => Unit('0.8 mm'),
      :pad_separation => Unit('0.9 mm'),
      :width => Unit('3.4 mm'),
      :height => Unit('1.9 mm')},
    '0805' => {
      :pad_width => Unit('1.05 mm'),
      :pad_height => Unit('1.30 mm'),
      :pad_separation => Unit('1.30 mm'),
      :width => Unit('4.3 mm'),
      :height => Unit('2.7 mm')},
    '1206' => {
      :pad_width => Unit('1.25 mm'),
      :pad_height => Unit('1.70 mm'),
      :pad_separation => Unit('2.30 mm'),
      :width => Unit('5.9 mm'),
      :height => Unit('3.20 mm')},
    '1812' => {
      :pad_width => Unit('1.25 mm'),
      :pad_height => Unit('2.30 mm'),
      :pad_separation => Unit('4.80 mm'),
      :width => Unit('5.9 mm'),
      :height => Unit('5.60 mm')},
    '2010' => {
      :pad_width => Unit('1.40 mm'),
      :pad_height => Unit('2.50 mm'),
      :pad_separation => Unit('3.50 mm'),
      :width => Unit('7.0 mm'),
      :height => Unit('3.60 mm')},
    '2512' => {
      :pad_width => Unit('2.00 mm'),
      :pad_height => Unit('3.20 mm'),
      :pad_separation => Unit('4.50 mm'),
      :width => Unit('9.0 mm'),
      :height => Unit('4.3 mm')}
  }
  def smd_size(size)
    SMD_SIZES[size]
  end


  class SmdTwoPad < Element
    attr :pad_width => Unit('0 mil')
    attr :pad_height => Unit('0 mil')
    attr :pad_separation => Unit('0 mil')
    
    def initialize(hash = {})
      super(hash)
      
      width = hash[:width] || (self.pad_width * 2) + self.pad_separation + Unit('1.4  mm')
      height = hash[:height] || self.pad_height + Unit('1.4 mm')
      # outline
      add_child(Rectangle.new(p1: Position.origin,
                              p2: Position.new(x: width,
                                               y: height),
                              thickness: Unit("4 mil")))
      
      
      inner_width = (self.pad_width * 2) + self.pad_separation
      pad_x = (width - inner_width) / 2.0
      pad_y = (height / 2)
      
      polarized_pin = hash[:polarized_pin]
      unless polarized_pin.nil?
        pol_x = if polarized_pin == 1 
                  (pad_x / 2.0) 
                else 
                  (width - (pad_x / 2.0)) 
                end
        add_child(Line.new(p1: Position.new(x: pol_x, y:0),
                           p2: Position.new(x: pol_x, y: height),
                           thickness: Unit('4 mil')))
      end
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
