class Module
  # provide attribute with default value
  def attr(hash)
    hash.each do |symbol, default_value|
      getter = symbol
      setter = "#{symbol}=".to_sym
      variable = "@#{symbol}".to_sym

      instance_variable_set(variable, default_value)

      define_method getter do
        if instance_variable_defined? variable
          instance_variable_get(variable) || default_value
        else
          default_value
        end
      end

      define_method setter do |value|
        instance_variable_set(variable, value)
      end
    end
  end
end
