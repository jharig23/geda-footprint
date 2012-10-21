class Quoted
  def initialize(value)
    @value = value
  end
  
  def to_s
    "\"#{@value}\""
  end
end


def quoted(value)
  Quoted.new(value)
end
