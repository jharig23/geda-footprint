# Base class for elements, allows
# easy population of values
class PcbElement
  def initialize(hash = {})
    hash.each do |key, value|
      send("#{key}=".to_sym, value)
    end
  end
end
