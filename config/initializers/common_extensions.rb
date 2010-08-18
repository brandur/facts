class Boolean
  def self.parse(obj)
    obj != nil && %w(true t 1 yes y).include?(obj.to_s.strip.downcase)
  end
end
