# PadLine is a line of pads

module GedaFootprint
  class PadLine < PolarLine

    attr :first_pad_number => 1
    attr :number_of_pads => 1
    attr :pad_2_pad_distance => Unit("0 mil")
    attr :pad_attr => nil
    attr :anchor => :middle
    def initialize(hash)
      super(hash)
    end

    def render_with(renderer)
      generate_pads.each do |pad|
        renderer.render(pad)
      end
    end

    def generate_pads()
      self.length = self.number_of_pads * self.pad_2_pad_distance
      polar_lines = connected_lines(
    end

  end
end
