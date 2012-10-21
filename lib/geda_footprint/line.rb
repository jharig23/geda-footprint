class Line < PcbElement
  attr :p1 => Position.origin, :p2 => Position.origin
  attr :thickness => Unit("0 mil")

  def render_with(renderer)
    renderer.open_line("ElementLine")
    renderer << [self.p1, self.p2, self.thickness]
    renderer.close_line("ElementLine")
  end
end
