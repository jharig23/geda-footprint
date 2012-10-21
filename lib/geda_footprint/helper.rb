module Helper
  def quote(text)
    text = text.to_s if text.respond_to?(to_s)
    "\"#{text}\""
  end

  
end
