#!/usr/bin/env ruby -w

v = File.open(ARGV[0]).readlines.map(&:to_i).sort

# 1st puzzle
ones = 1
threes = 1

v.each_cons(2) do |(a, b)|
  if b - a == 1
    ones += 1
  else
    threes += 1
  end
end

puts ones * threes

# 2nd puzzle
m = v.max + 3
dp = {}
dp[0] = 1

v.each do |adapter|
  dp[adapter] = dp.fetch(adapter - 3, 0) + dp.fetch(adapter - 2, 0) + dp.fetch(adapter - 1, 0)
end

dp[m] = dp.fetch(m - 3, 0) + dp.fetch(m - 2, 0) + dp.fetch(m - 1, 0)

puts dp[m]
