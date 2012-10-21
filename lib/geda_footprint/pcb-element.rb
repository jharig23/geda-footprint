class PcbElement
  def initialize(hash = {})
    hash.each do |key, value|
      send("#{key}=".to_sym, value)
    end
  end
end
