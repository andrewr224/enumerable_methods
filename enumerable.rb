module Enumerable

  # #my_each method should act the same as #each
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
    end

    self
  end

  def my_each_with_index
    type = self.class

    # should not work on Hashes
    i = 0
    if type == Array || type == Range
      for item in self
        yield(item, i)
        i+=1
      end
    end

    self
  end

  def my_select
    return "#<Enumerator: #{self}:my_select>" unless block_given?
    type = self.class
    # create an empty array that will later be populated...
    result = []

    if type == Array || type == Range
      self.my_each do |item|
        if yield(item)
          result << item
        end
      end
    elsif type == Hash
      # or changed into a Hash and populated
      result = {}
      self.my_each do |key, value|
        if yield(key, value)
          result[key] = value
        end
      end
    end

    result
  end

  def my_all?
    type = self.class
    # returns true unless something is falthy
    result = true

    # returns true if no block passed
    if block_given?
      if type == Array || type == Range
        self.my_each do |item|
          result = false unless yield item
        end
      elsif type == Hash
        self.my_each do |key, value|
          result = false unless  yield(key, value)
        end
      end
    end

    result
  end

  def my_any?
    type = self.class
    # returns false unless something is thruthy
    result = false

    if block_given?
      if type == Array || type == Range
        self.my_each do |item|
          result = true if yield item
        end
      elsif type == Hash
        self.my_each do |key, value|
          result = true if  yield(key, value)
        end
      end
    else
      # returns true if no block passed
      result = true
    end

    result
  end

  def my_none?
    type = self.class
    # returns false unless something is thruthy
    result = true

    # returns false if no block passed
    if block_given?
      if type == Array || type == Range
        self.my_each do |item|
          result = false if yield item
        end
      elsif type == Hash
        self.my_each do |key, value|
          result = false if  yield(key, value)
        end
      end
    elseresult = []

    if type == Array || type == Range
      return "#<Enumerator: #{self}:my_select>" unless block_given?

      self.my_each do |item|
        if yield(item)
          result << item
        end
      end
    elsif type == Hash
      return "#<Enumerator: #{self}:my_select>" unless block_given?

      # or changed into a Hash and populated
      result = {}
      self.my_each do |key, value|
        if yield(key, value)
          result[key] = value
        end
      end
    end

    result
      result = false
    end

    result
  end

  def my_count(arg = nil)
    type = self.class

    if block_given?
      # create a temporary array that will later be populated and measured
      temp = []

      if type == Array || type == Range
        self.my_each do |item|
          if yield(item)
            temp << item
          end
        end
      elsif type == Hash
        # or changed into a Hash and populated
        temp = {}
        self.my_each do |key, value|
          if yield(key, value)
            temp[key] = value
          end
        end
      end

      result = temp.length
    elsif arg != nil
      if type == Array || type == Range
        temp = self.my_select do |item|
          item == arg
        end
        result = temp.length
      elsif type == Hash
        result = 0
      end
    else
      if type == Array || type == Hash
        result = self.length
      elsif type == Range
        result = self.to_a.length
      end
    end
    result
  end

  def my_map
    return "#<Enumerator: #{self}:my_map>" unless block_given?
    type = self.class

    result = []

    if type == Array || type == Range
      self.my_each do |item|
        result << yield(item)
      end
    elsif type == Hash
      self.my_each do |key, value|
        result << yield(key, value)
      end
    end

    result
  end

  def my_inject
  end

end

# checking if works
x = [1,2,3,5,6]
y = {key1: 1, key2: 2, key3: 3}
z = (1..9)
a = {"string" => 42}

x.my_map do |e|
  e * 2
end

z.my_map do |e|
  e * 2
end

a.my_map do |k, v|
  k * 2
end

y.my_map do |k, v|
  v * 24
end
