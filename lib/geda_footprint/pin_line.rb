# PinLine is a line of pins

module GedaFootprint
  class PinLine < ObjectLine

    attr :first_pin_number => 1
    attr :pin_diameter => Unit("0 mil")
    attr :drill_diameter => Unit("0 mil")

    
    def initialize(hash)
      super(hash)
    end

    
    def generate_objects()
      pin_positions = positions(self.number_of_things)
      pin_number = self.first_pin_number
      
      pin_positions.each_with_index.map do |position, i|
        pin = Pin.new(p: position, number: pin_number, diameter: self.pin_diameter, 
                      drill_dia: self.drill_diameter)
        pin_number += 1
        pin
      end
    end
  end
end
