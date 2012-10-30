module GedaFootprint
  class Position
    require 'ruby-units'
    include Helper
    
    attr x: Unit("0 mil"), y: Unit("0 mil")
    
    def initialize(hash = nil)
      unless hash.nil?
        hash.each do |key, value|
          self.send("#{key}=".to_sym, value)
        end
      end
    end
    
    def self.origin
      Position.new
    end

    def element_name
      "Position"
    end
    
    def render_with(renderer)
      renderer << [x, y]
    end
    
    def +(pos)
      math_oper(:+, pos)
    end
    
    def -(pos)
      math_oper(:-, pos)
    end
    
    # convert to simple values -1, 0 or 1 based on value
    def directionalize
      Position.new(x: sign(self.x), y: sign(self.y))
    end
    
    def clone
      Position.new(x: self.x, y: self.y)
    end
    
    def to_s
      "Point[x=#{self.x}; y=#{self.y}]"
    end
    
    private
    def math_oper(oper, pos)
      result = self.clone
      
      [:x, :y].each do |getter|
        setter = "#{getter}=".to_sym
        if pos.respond_to?(getter)
          result.send(setter,
                      self.send(getter).send(oper, pos.send(getter)))
        end
      end
      return result
    end
  end
end
