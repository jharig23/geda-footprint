

module GedaFootprint
  # the base formula for placing object (pads, pins) along the path of 
  # a line
  class ObjectLine < PolarLine
    attr :number_of_things => 1
    attr :pitch => Unit("0 mil")
    attr :anchor => :middle

    def initialize(hash)
      super(hash)

      # likely, the caller will not send :number_of_things.  For example,
      # it might be :number_of_pads.  Let's try and parse it out
      hash.each do |key, value|
        cand_key = key.to_s
        if cand_key =~ /^number_of_.+$/
          self.number_of_things = value
        end
      end

      self.length = (self.number_of_things - 1) * self.pitch
    end

    def render_with(renderer)
      generate_objects.each do |object|
        object.render_with(renderer)
      end
    end

  end
end
