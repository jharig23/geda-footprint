module GedaFootprint
  SMD_SIZES = { '0603' => {
      :pad_length => Unit('0.9 mm'),
      :pad_thickness => Unit('0.8 mm'),
      :pad_separation => Unit('0.9 mm'),
      :width => Unit('3.4 mm'),
      :height => Unit('1.9 mm'),
      :pad_anchor => :end},
    '0805' => {
      :pad_length => Unit('1.05 mm'),
      :pad_thickness => Unit('1.30 mm'),
      :pad_separation => Unit('1.30 mm'),
      :width => Unit('4.3 mm'),
      :height => Unit('2.7 mm'),
      :pad_anchor => :end},
    '1206' => {
      :pad_length => Unit('1.25 mm'),
      :pad_thickness => Unit('1.70 mm'),
      :pad_separation => Unit('2.30 mm'),
      :width => Unit('5.9 mm'),
      :height => Unit('3.20 mm'),
      :pad_anchor => :end},
    '1812' => {
      :pad_length => Unit('1.25 mm'),
      :pad_thickness => Unit('2.30 mm'),
      :pad_separation => Unit('4.80 mm'),
      :width => Unit('5.9 mm'),
      :height => Unit('5.60 mm'),
      :pad_anchor => :end},
    '2010' => {
      :pad_length => Unit('1.40 mm'),
      :pad_thickness => Unit('2.50 mm'),
      :pad_separation => Unit('3.50 mm'),
      :width => Unit('7.0 mm'),
      :height => Unit('3.60 mm'),
      :pad_anchor => :end},
    '2512' => {
      :pad_length => Unit('2.00 mm'),
      :pad_thickness => Unit('3.20 mm'),
      :pad_separation => Unit('4.50 mm'),
      :width => Unit('9.0 mm'),
      :height => Unit('4.3 mm'),
      :pad_anchor => :end}
  }
  def smd_size(size)
    SMD_SIZES[size]
  end


  class SmdTwoPad < Element
    attr :pad_length => Unit('0 mil')
    attr :pad_thickness => Unit('0 mil')
    attr :pad_separation => Unit('0 mil')
    
    def initialize(hash = {})
      super(hash)

      width = hash[:width] || (self.pad_length * 2) + self.pad_separation + Unit('1.4  mm')
      height = hash[:height] || self.pad_thickness + Unit('1.4 mm')
      anchor = hash[:pad_anchor] || :middle
      # outline
      border = Rectangle.new(p: Position.new(x: Unit('0 mm'), y: height),
                             width: width,
                             height: height)
      
      #  small height to force calculation of theta for connected line
      pad_rect = border.new_centered(width: self.pad_separation,
                                     height: Unit('0.0000001 mil')) 
      
      left = PadLine.new(p: pad_rect.top_left, theta: -90.degrees,
                         pad_thickness: self.pad_thickness,
                         pad_length: self.pad_length,
                         first_pad_number: 1,
                         number_of_pads: 1,
                         anchor: anchor)
      
      right = PadLine.new(p: pad_rect.top_right, theta: 90.degrees,
                          pad_thickness: self.pad_thickness,
                          pad_length: self.pad_length,
                          first_pad_number: 2,
                          number_of_pads: 1,
                          anchor: anchor)
      
      unless hash[:polarized_pin].nil?
        polarized_pin = hash[:polarized_pin]
        space = Unit('0.8 mm')
        if polarized_pin == 1
          add_child(Rectangle.new(p: Position.new(x: space * -1,
                                                  y: height),
                                  width: space,
                                  height: height))
        else
          add_child(Rectangle.new(p: Position.new(x: width,
                                                  y: height),
                                  width: space,
                                  height: height))
        end
      end
      add_child(border)
      add_child(left)
      add_child(right)



    end
  end
end
