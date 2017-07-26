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

  def my_select(&block)
    type = self.class
    # create an empty array that will later be populated...
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

      # or changed into a Hash and populated
      result = {}
      self.my_each do |key, value|
        if block.call(key, value)
          result[key] = value
        end
      end
    end

    result
  end

  def my_all?(&block)
    type = self.class
    # returns true unless something is falthy
    result = true

    # returns true if no block passed
    if block_given?
      if type == Array || type == Range
        self.my_each do |item|
          result = false unless block.call(item)
        end
      elsif type == Hash
        self.my_each do |key, value|
          result = false unless  block.call(key, value)
        end
      end
    end

    result
  end

  def my_any?(&block)
    type = self.class
    # returns false unless something is thruthy
    result = false

    if block_given?
      if type == Array || type == Range
        self.my_each do |item|
          result = true if block.call(item)
        end
      elsif type == Hash
        self.my_each do |key, value|
          result = true if  block.call(key, value)
        end
      end
    else
      # returns true if no block passed
      result = true
    end

    result
  end
end

# checking if works
x = [1,2,3,5,6]
y = {key1: 1, key2: 2, key3: 3}
z = (1..9)

x.my_any? do |e|
  e > 1
end

z.my_any? do |e|
  e >= 10
end

y.my_any? do |k, v|
  v > 2
end
