# PadLine is a line of pads

module GedaFootprint
  class PadLine < PolarLine

    attr :first_pad_number => 1
    attr :number_of_pads => 1

    attr :pitch => Unit("0 mil")
    attr :pad_thickness => Unit("0 mil")
    attr :pad_length => Unit("0 mil")

    attr :anchor => :middle
    def initialize(hash)
      super(hash)
    end


    def generate_pads()
      self.length = (self.number_of_pads - 1) * self.pitch
      tangent_lines = connected_lines(self.number_of_pads, self.pad_length, 90.degrees, self.anchor)
      pad_number = self.first_pad_number
      tangent_lines.map do |line|
        number = pad_number
        pad_number = pad_number + 1
        Pad.new(p1: line.p1, p2: line.p2, thickness: self.pad_thickness, number: number, adjust_endpoints: true)
      end
    end

    def render_with(renderer)
      generate_pads.each do |pad|
        pad.render_with(renderer)
      end
    end

  end
end
