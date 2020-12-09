#!/usr/bin/env ruby -w

size = 25
code = 0

v = File.open(ARGV[0]).readlines.map(&:to_i)

# 1st puzzle
current = v[0...size]
v[size..].each do |n|
  found_pair = false
  current.each do |c|
    if c != n - c && current.include?(n - c)
      found_pair = true
      break
    end
  end

  if !found_pair
    code = n
    break
  end

  current.shift
  current << n
end

puts code

# 2nd puzzle
original = v.dup
current_sum = v[0]
start = 0
i = 1
while i <= v.size
  while current_sum > code && start < i - 1
    current_sum -= v[start]
    start += 1
  end

  if current_sum == code
    puts original[start..i - 1].min + original[start..i - 1].max
    break
  end

  current_sum += v[i] if i < v.size

  i += 1
end
