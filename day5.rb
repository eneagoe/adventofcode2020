#!/usr/bin/env ruby -w

ids = File.open(ARGV[0]).map do |line|
  row, column = 0, 0
  left, right = 0, 127

  line[0..6].each_char do |c|
    mid = (left + right) / 2
    if c == "F"
      right = mid
    else
      left = mid + 1
    end
  end

  row = left

  left, right = 0, 7
  line[7..10].each_char do |c|
    mid = (left + right) / 2
    if c == "L"
      right = mid
    else
      left = mid + 1
    end
  end

  column = right

  row * 8 + column
end

# 1st puzzle
puts ids.max

# 2nd puzzle
a = ids.min
b = ids.max
s = (a + b) * (b - a + 1) / 2

puts s - ids.sum
