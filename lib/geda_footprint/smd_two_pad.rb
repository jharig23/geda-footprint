class SmdTwoPad < Element
  
  attr :width => Unit('0 mil'), :height => Unit('0 mil')
  attr :pad_length => Unit('0 mil')
  attr :pad_height => Unit('0 mil')
  attr :pad_separation => Unit('0 mil')

  def initialize(hash = {})
    super(hash)
    puts ("helo")
    # outline
    off = Unit('20 mil')
    #add_child(Rectangle.new(p1: Position.new(x: off * -1, y: off * -1,
    #                        p2: Position.new(x: self.width + off, y: self.height + off),
    #                        thickness: Unit("5 mil"))))
  end
end

