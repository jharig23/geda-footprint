module GedaFootprint

  # Base class for elements, allows
  # easy population of values
  class PcbElement
    def initialize(hash = {})
      hash.each do |key, value|
        setter = "#{key}=".to_sym
        send(setter, value) if self.respond_to?(setter)
      end
    end
  end
end
