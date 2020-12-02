#!/usr/bin/env ruby -w

first_rule_count = 0
second_rule_count = 0

File.open(ARGV[0]).each do |line|
  /^(?<min>\d+)-(?<max>\d+)\s+(?<ch>\w):\s+(?<password>\w+)$/ =~ line

  min = min.to_i
  max = max.to_i

  first_rule_count += 1 if (min.to_i..max.to_i).cover? password.count(ch)

  second_rule_count += 1 if (password[min - 1] == ch && password[max - 1] != ch) || (password[min - 1] != ch && password[max - 1] == ch)
end

# 1st puzzle
puts first_rule_count

# 2nd puzzle
puts second_rule_count
