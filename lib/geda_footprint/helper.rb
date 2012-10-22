module Helper
  def quote(text)
    text = text.to_s if text.respond_to?(to_s)
    "\"#{text}\""
  end

  def sign(num)
    case
    when num > 0 then 1
    when num < 0 then -1
    else 0
    end
  end
end
