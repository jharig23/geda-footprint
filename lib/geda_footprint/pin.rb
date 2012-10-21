class Pin
  include Helper
  
  attr :p => Position.origin
  attr :thickness => Unit("0 mil")
  attr :clearance => Unit("0 mil")
  attr :mask_dia => Unit("0 mil")
  attr :drill_dia => Unit("0 mil")
  attr :name => ""
  attr :number => 0
  attr :flags => ""

  def render_with(renderer)
    renderer.open_line("Pin")
    renderer << [self.p, self.thickness, self.clearance, self.mask_dia,
                 self.drill_dia, self.name, quoted(self.number), self.flags]
    renderer.close_line("Pin")
  end
end
