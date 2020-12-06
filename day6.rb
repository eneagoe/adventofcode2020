#!/usr/bin/env ruby -w

groups = File.open(ARGV[0]).readlines.join.split(/\n\n+/)

# 1st puzzle
total = groups.map do |g|
  score = [0] * 26

  g.split(/\n+/).each do |answers|
    answers.each_char do |c|
      score[c.ord - 'a'.ord] = 1
    end
  end

  score.sum
end

puts total.sum

# 2nd puzzle
second_total = groups.map do |g|
  score = [0] * 26
  answers = g.split(/\n+/)
  n = answers.size

  answers.each do |answer|
    answer.each_char do |c|
      score[c.ord - 'a'.ord] += 1
    end
  end

  score.count { |c| c == n }
end

puts second_total.sum
