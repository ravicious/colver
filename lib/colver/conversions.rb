class String
  def to_color
    Color.new(self)
  end
end

class Array
  def to_color
    Color.new(self)
  end
end

class Integer
  def to_color
    Color.new(to_s)
  end
end
