module GedaFootprint
  class Renderer
    include Helper

    def initialize
      @line = ''
      @rendered_element = ''
    end

    # Render should not be called by elements!
    def render(element)
      if element.respond_to?(:render_with)
        @transformation = Transformation.new
        element.render_with(@transformation)
        element.render_with(self)
      end
    end

    def render_to_file(element, filename)
      self.render(element)
      File.open(filename, "w") do |f|
        f.puts self.rendered_element
      end
    end

    def open_line(tag_name)
      @line = tag_name << "["
      @first_unit = true
    end

    def close_line(tag_name)
      @line << "]"
      append_line(@line)

    end

    def append_line(line)
      @rendered_element << "#{line}\n"
    end

    def rendered_element
      @rendered_element
    end

    def<<(thing)
      render_attribute(thing)
    end

    def render_attribute(thing)
      unless thing.nil?
        if thing.is_a?(Unit)
          val = (thing >> 'zil').scalar.to_i
          append_to_line("#{val}")
        elsif thing.is_a?(String)
          append_to_line(quote(thing))
        elsif thing.is_a?(Position)
          render_attribute(@transformation.transform(thing).to_a)
        elsif thing.respond_to?(:each)
          thing.each { |other_thing| render_attribute(other_thing) }
        elsif thing.respond_to?(:render_with)
          thing.render_with(self)
        else
          append_to_line(thing.to_s)
        end
      end
      @line
    end

    def line
      @line
    end

    private
    def append_to_line(value)
      @line << " " unless @first_unit
      @line << value
      @first_unit = false
    end
  end
end
