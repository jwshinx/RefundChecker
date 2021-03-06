module Sortable
  def manage_all(left, right, order)
    while((left.length > 0) && (right.length > 0)) do
      if order == :asc
        yield(left.first, right.first)
      else
        yield(right.first, left.first)
      end
    end
  end

  def merge(left, right, order, attribute)
    result = Array.new
    manage_all(left, right, order) do |x, y|
      if(x.send(attribute) <= y.send(attribute)) then
        result << left.first
        left.shift
      else
        result << right.first
        right.shift
      end
    end
    if(left.length > 0) then
      result.concat(left)
    else
      result.concat(right)
    end
    return result
  end

  def sort_array(array, order, attribute)
    left = Array.new
    right = Array.new
    result = Array.new
    midint = 0
    if array.length <= 1
      return array
    else
      midint = array.length / 2
      for x in 0...midint do
        left << array[x]
      end
      for x in midint...array.length do
          right << array[x]
      end
      left = sort_array(left, order, attribute)
      right = sort_array(right, order, attribute)
      result = merge(left, right, order, attribute)
      return result
    end
  end
end
