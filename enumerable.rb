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

  def my_select(&block)
    type = self.class
    result = []

    if type == Array || type == Range
      return "#<Enumerator: #{self}:my_select>" unless block_given?

      self.my_each do |item|
        if block.call(item)
          result << item
        end
      end
    elsif type == Hash
      return "#<Enumerator: #{self}:my_select>" unless block_given?

      result = {}
      self.my_each do |key, value|
        if block.call(key, value)
          result[key] = value
        end
      end
    else
      return "Error: can't call the method #my_select on #{type}"
    end

    result
  end
end

# checking if works
x = [1,2,3,5,6]
y = {key1: 1, key2: 2, key3: 3}
z = (1..9)

x.my_select do |e|
  e > 2
end

z.my_select do |e|
  e > 2
end

y.my_select do |k, v|
  k == :key1
end

y.select do |k, v|
  v > 2
end

"sting".my_select do |e|
  e > 2
end

:symbol.my_select do |e|
  e > 2
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
