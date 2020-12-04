#!/usr/bin/env ruby -w

require 'set'
require 'byebug'

VALID_SET = Set.new(['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid', 'cid'])
NORTH_POLE_VALID = Set.new(['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'])

passports = File.open(ARGV[0]).readlines.join.split(/\n\n+/).sort!
statuses = []

# 1st puzzle
count = passports.count do |passport|
  fields = Set.new(passport.gsub(/\n/, " ").split.map { |f| f.split(/:/)[0] })
  valid = fields == VALID_SET || fields == NORTH_POLE_VALID
  statuses << valid

  valid
end

puts count

# 2nd puzzle
valid_count = passports.each_with_index.count do |passport, i|
  valid = statuses[i]

  passport.gsub(/\n/, " ").split.map { |f| f.split(/:/) }.each do |(field, value)|
    valid_field = case field
                  when "byr"
                    (1920..2002).cover?(value.to_i)
                  when "iyr"
                    (2010..2020).cover?(value.to_i)
                  when "eyr"
                    (2020..2030).cover?(value.to_i)
                  when "hgt"
                    value[-2..-1] == "cm" && (150..193).cover?(value[0..-3].to_i) || value[-2..-1] == "in" && (59..76).cover?(value[0..-3].to_i)
                  when "hcl"
                    value =~ /^#([0-9]|[a-f]){6}$/
                  when "ecl"
                    %w(amb blu brn gry grn hzl oth).include?(value)
                  when "pid"
                    value =~ /^\d{9}$/
                  when "cid"
                    true
                  end
    if !valid_field
      valid = false
      break
    end
  end

  valid
end

puts valid_count
