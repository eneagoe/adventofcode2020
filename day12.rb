#!/usr/bin/env ruby -w

moves = File.open(ARGV[0]).readlines.map(&:chomp)

left = [[1, 0], [0, 1], [-1, 0], [0, -1]]
right = [[1, 0], [0, -1], [-1, 0], [0, 1]]

# 1st puzzle
position = [0, 0]
direction = [1, 0]

moves.each do |move|
  /(?<dir>\w)(?<distance>\d+)/ =~ move

  distance = distance.to_i

  case dir
  when "N"
    position = [position.first, position.last + distance]
  when "S"
    position = [position.first, position.last - distance]
  when "E"
    position = [position.first + distance, position.last]
  when "W"
    position = [position.first - distance, position.last]
  when "L"
    direction = left[(left.index(direction) + distance / 90) % 4]
  when "R"
    direction = right[(right.index(direction) + distance / 90) % 4]
  when "F"
    position = [position.first + distance * direction.first, position.last + distance * direction.last]
  end
end

puts position.first.abs + position.last.abs

# 2nd puzzle
ship = [0, 0]
waypoint = [10, 1]

moves.each do |move|
  /(?<dir>\w)(?<distance>\d+)/ =~ move

  distance = distance.to_i
  dx, dy = waypoint.first - ship.first, waypoint.last - ship.last
  d = distance / 90

  case dir
  when "N"
    waypoint = [waypoint.first, waypoint.last + distance]
  when "S"
    waypoint = [waypoint.first, waypoint.last - distance]
  when "E"
    waypoint = [waypoint.first + distance, waypoint.last]
  when "W"
    waypoint = [waypoint.first - distance, waypoint.last]
  when "L"
    d.times { dx, dy = -dy, dx }
    waypoint = [ship.first + dx, ship.last + dy]
  when "R"
    d.times { dx, dy = dy, -dx }
    waypoint = [ship.first + dx, ship.last + dy]
  when "F"
    ship = [ship.first + dx * distance, ship.last + dy * distance]
    waypoint = [ship.first + dx, ship.last + dy]
  end
end

puts ship.first.abs + ship.last.abs
