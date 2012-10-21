class Pad
  include Helper

  attr :p1 => Position.origin, :p2 => Position.origin
  attr :thickness => Unit("0 mil")
  attr :clearance => Unit("0 mil")
  attr :mask_width => Unit("0 mil")
  attr :name => ""
  attr :number => 0
  attr :flags => ""

  def initialize(hash = {})
    hash.each do |key, value|
      send("#{key}=".to_sym, value)
    end
  end

  def render_with(renderer)
    renderer.open_line("Pad")
    renderer << [self.p1, self.p2, self.thickness,
                 self.clearance, self.mask_width, self.name,
                 quoted(self.number), self.flags]
    renderer.close_line("Pad")
  end

end
