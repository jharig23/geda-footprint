require_relative 'footprints'


renderer = Renderer.new
e = QuadPackage.new

renderer.render(e)


puts renderer.rendered_element
