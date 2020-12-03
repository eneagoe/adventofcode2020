#!/usr/bin/env ruby -w

dy = 3
dx = 1

pattern = []

File.open(ARGV[0]).each do |line|
  pattern << line.chomp * 3
end

n = pattern.size

# very inefficient, but fast enough for the input sizes
field = pattern.map { |line| line * n }

# 1st puzzle
x, y = 0, 0
count3 = 0

while x < field.size
  count3 += 1 if field[x][y] == "#"
  x += dx
  y += dy
end

puts count3

# 2nd puzzle
dy, dx = 1, 1
x, y = 0, 0
count1 = 0

while x < field.size
  count1 += 1 if field[x][y] == "#"
  x += dx
  y += dy
end

dy, dx = 5, 1
x, y = 0, 0
count5 = 0

while x < field.size
  count5 += 1 if field[x][y] == "#"
  x += dx
  y += dy
end

dy, dx = 7, 1
x, y = 0, 0
count7 = 0

while x < field.size
  count7 += 1 if field[x][y] == "#"
  x += dx
  y += dy
end

dy, dx = 1, 2
x, y = 0, 0
count1_2 = 0

while x < field.size
  count1_2 += 1 if field[x][y] == "#"
  x += dx
  y += dy
end

puts count1 * count3 * count5 * count7 * count1_2
