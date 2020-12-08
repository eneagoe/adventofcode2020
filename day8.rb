#!/usr/bin/env ruby -w

require 'set'

instructions = File.open(ARGV[0]).readlines.map do |line|
  op, arg = line.split
  [op, arg.to_i]
end

visited = Set.new
acc, pc = 0, 0

# 1st puzzle
while !visited.include?(pc)
  visited.add(pc)
  op, arg = instructions[pc]
  case op
  when "acc"
    acc += arg
    pc += 1
  when "jmp"
    pc += arg
  when "nop"
    pc += 1
  end
end

puts acc

# 2nd puzzle
# brute-force, try replacing all matches and run the program
instructions.each_with_index do |(op, arg), i|
  next unless ["nop", "jmp"].include?(op)

  visited = Set.new
  acc, pc = 0, 0

  commands = instructions.dup
  commands[i] = if op == "nop"
                  ["jmp", arg]
                else
                  ["nop", arg]
                end

  finished = true
  while pc < commands.size
    if visited.include?(pc)
      finished = false
      break
    end
    visited.add(pc)
    op, arg = commands[pc]
    case op
    when "acc"
      acc += arg
      pc += 1
    when "jmp"
      pc += arg
    when "nop"
      pc += 1
    end
  end

  if finished
    puts acc
    break
  end
end
