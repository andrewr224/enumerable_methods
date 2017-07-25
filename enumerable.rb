module Enumerable
  def my_each
    # checking for types
    type = self.class

    if type == Array || type == Range
      for item in self
        yield item
      end
    elsif type == Hash
      keys = self.keys
      for key in keys
        value = self[key]
        yield(key, value)
      end
    else
      return "Error: can't call the method #my_each on #{type}"
    end

    self
  end

end


# checking if works
x = [1,2,3]
y = {key1: "Value 1", key2: "Value 2", key3: "Value 3"}
z = (1..9)

x.my_each do |e|
  print e
end

z.my_each do |e|
  print e
end

y.my_each do |k, v|
  print "#{k} is a #{v}"
end

"sting".my_each do |e|
  print e
end

:symbol.my_each do |e|
  print e
end




 def my_each
    # check if it's an array or a hash

    type = self.class

    case type
    when Array
      for item in self
        yield item
      end
    when Hash
      keys = self.keys
      for key in keys
        value = self[key]
        yield(key, value)
      end
    else
      return "Error: can't call the method #my_each on #{type}"
    end

    self
  end
