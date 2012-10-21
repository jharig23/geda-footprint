class Element <  PcbElement
  require 'ruby-units'

  attr :flags => "", :description => "", :name => "", :value => ""
  attr :mark_position => Position.origin
  attr :text_position => Position.origin, :text_direction => 0, :text_scale => 100, :text_flags => ""

  def initialize(hash)
    super(hash)
    @children = []
  end

  def add_child(child)
    @children << child
  end


  def render_with(renderer)
    renderer.open_line("Element")
    renderer << [self.flags, self.description, self.name,
                 self.value, self.mark_position,
                 self.text_position, self.text_direction,
                 self.text_scale, self.text_flags]

    renderer.close_line("Element")
    renderer.append_line "("

    @children.each do |child|
      renderer.render(child)
    end

    renderer.append_line ")"

  end


end
