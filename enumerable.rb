module Enumerable
  def my_each
    # checking for types, as it should support array, ranges, and hashes only
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

  def my_each_with_index
    type = self.class

    i = 0
    if type == Array || type == Range
      for item in self
        yield(item, i)
        i+=1
      end
    else
      return "Error: can't call the method #my_each_with_index on #{type}"
    end

    self
  end
end


# checking if works
x = [1,2,3]
y = {key1: "Value 1", key2: "Value 2", key3: "Value 3"}
z = (1..9)

x.my_each_with_index do |e, i|
  print "#{e} is the #{i}'s "
end

z.my_each_with_index do |e, i|
  print "#{e} is the #{i}'s "
end

y.my_each_with_index do |k, v|
  print "#{k} is a #{v}"
end

"sting".my_each_with_index do |e|
  print e
end

:symbol.my_each_with_index do |e|
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
