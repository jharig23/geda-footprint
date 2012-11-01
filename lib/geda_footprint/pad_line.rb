# PadLine is a line of pads
# The line is from position p1 to p2
#
#
# The origin(x:0, y:0) is top left and increases to the right and down
#
# The pad length is (positive_pad_length + negative_pad_length)
# positive_pad_length and negative_pad_length are used to offset the start
# of the pad, if you want.
#
# We use the right-hand method to determine positive direction
#  Orient your right hand in the direction of the line, and point your
#  thumb.  The direction of your thumb is positive.
#
module GedaFootprint
  class PadLine < PolarLine

    attr :first_pad_number => 1
    attr :number_of_pads => 1
    attr :pad_2_pad_distance => Unit("0 mil")
    attr :pad_attr

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

    end

  end
end
