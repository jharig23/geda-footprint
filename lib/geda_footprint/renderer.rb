module GedaFootprint
  class Renderer
    include Helper
    
    def initialize
      @line = ''
      @rendered_element = ''
    end
    
    def render(element)
      element.render_with(self) if element.respond_to?(:render_with)
      rendered_element
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
