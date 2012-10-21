def reload!
  Dir['*.rb'].each {|f| load f }
end
