module GedaFootprint
  # Transformation is used to convert the rendered positions into something that is
  # more acceptable to PCB.  Basically, PCB uses y+ pointing down, which can be
  # really confusing because we use trig. functions.

  class Transformation

    def initialize()
      @largest_y =  Unit('0 mm')
    end

    def transform(p)
      Position.new(x: p.x, y: (@largest_y - p.y))
    end

    def render_attribute(thing)
      unless thing.nil?
        if thing.is_a?(Position)
          @largest_y = thing.y if thing.y > @largest_y
        elsif thing.respond_to?(:each)
          thing.each { |other_thing| render_attribute(other_thing) }
        elsif thing.respond_to?(:render_with)
          thing.render_with(self)
        end
      end
    end

    def <<(thing)
      render_attribute(thing)
    end




    def method_missing(meth, *args, &block)

    end
  end
end
