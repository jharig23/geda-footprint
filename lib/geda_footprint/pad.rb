module GedaFootprint
  class Pad
    include Helper

    attr :p1 => Position.origin, :p2 => Position.origin
    attr :thickness => Unit("0 mil")
    attr :clearance => Unit("0 mil")
    attr :mask_width => Unit("0 mil")
    attr :name => ""
    attr :number => 0
    attr :flags => "square"


    @split_pads = nil

    def initialize(hash = {})
      hash.each do |key, value|
        send("#{key}=".to_sym, value) unless key == :adjust_endpoints
      end
      @split_pads = []

      adjust_endpoints if hash[:adjust_endpoints]
    end

    def render_with(renderer)
      if @split_pads.empty?
        renderer.open_line("Pad")
        renderer << [self.p1, self.p2, self.thickness,
                     self.clearance, self.mask_width, self.name,
                     quoted(self.number), self.flags]
        renderer.close_line("Pad")
      else
        @split_pads.each { |pad| pad.render_with(renderer) }
      end

    end

    private

    # adjust endpoints p1 and p2 such that the initially provided value is actually where the pads end
    # note, thickness is still required.
    def adjust_endpoints
      pl = PolarLine.new(p1: self.p1, p2: self.p2)


      if pl.length > self.thickness
        adjustment = self.thickness / 2
        pl.translate!(0, adjustment)
        pl.length = pl.length - self.thickness
        self.p1 = pl.p
        self.p2 = pl.p2
      else
        # if length is smaller than thickness, this will
        # not work, we need to subdivide pad.

        # split into 2 pads w/ same length, but half thickness
        # new pad will adjust endpoints also.
        @split_pads = []
        new_thickness = self.thickness / 2.0
        [90.degrees, -90.degrees].each do |direction|
          pad_pl = pl.clone
          pad_pl.translate!(direction, new_thickness / 2.0)
          @split_pads << Pad.new(p1: pad_pl.p1, p2: pad_pl.p2, thickness: new_thickness, number: self.number, flags: self.flags, adjust_endpoints: true)
        end


      end
    end
  end
end
