class Arc
  attr :p => Position.origin
  attr :width => Unit('0 mil')
  attr :height => Unit('0 mil')
  attr :start_angle => 0
  attr :delta_angle => 0
  attr :thickness => Unit("0 mil")
  

  def render_with(renderer)
    renderer.open_line("ElementArc")
    renderer << [self.p, self.width, self.height,
                 self.start_angle, self.delta_angle,
                 self.thickness]
    renderer.close_line("ElementArc")
  end
end
