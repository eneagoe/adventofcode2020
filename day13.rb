#!/usr/bin/env ruby -w

timestamp, schedule = File.open(ARGV[0]).readlines.map(&:chomp)

# 1st puzzle
timestamp = timestamp.to_i
buses = schedule.split(/,/).reject { |b| b == "x" }.map(&:to_i)

closest = buses.min_by do |b|
  q, r = timestamp.divmod(b)

  r.zero? ? 0 : (q + 1) * b - timestamp
end

q, r = timestamp.divmod(closest)
wait = r.zero? ? 0 : (q + 1) * closest - timestamp

puts closest * wait

# 2nd puzzle
buses = schedule.split(/,/).each_with_index.map { |b, i| [b.to_i, i] if b != "x" }.compact

first, offset = buses[0][0], buses[0][0]
buses[1..-1].each do |bus|
  while (first + bus[1]) % bus[0] != 0
    first += offset
  end
  offset *= bus[0]
end

puts first
