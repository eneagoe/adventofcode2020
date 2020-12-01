#!/usr/bin/env ruby -w

require 'set'

a = []

File.open(ARGV[0]).each do |m|
  a << m.to_i
end

v = Set.new(a)

# 1st puzzle
v.each do |x|
  if v.include?(2020 - x)
    puts x * (2020 - x)
    break
  end
end

# 2nd puzzle - not efficient, but input is very small
a.each_with_index do |x, i|
  a[i + 1..].each_with_index do |y, j|
    if a[j + 1..].include?(2020 - x - y)
      puts x * y * (2020 - x - y)
      exit
    end
  end
end
