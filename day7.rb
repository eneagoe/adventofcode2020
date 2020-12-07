#!/usr/bin/env ruby -w

def breadth_first_search(g, source)
  node_queue = [source]

  loop do
    curr_node = node_queue.pop

    return false if curr_node == nil
    return true if curr_node == "shiny gold"

    children = g[curr_node].map(&:first)

    node_queue = children + node_queue
  end
end

def count_bags(g, color)
  g[color].map(&:last).sum + g[color].map { |(container, count)| count * count_bags(g, container) }.sum
end

g = {}

File.open(ARGV[0]).each do |line|
  /^(?<color>.*)\s+bags\s+contain\s+(?<rest>.*)$/ =~ line
  g[color] = [] unless g.key?(color)

  rest.split(/,\s+/).each do |content|
    /^(?<count>\d+)\s+(?<bag>.*)\s+bags?.?$/ =~ content
    g[color] << [bag, count.to_i] if bag
  end
end

# 1st puzzle
puts g.keys.count { |color| color != "shiny gold" && breadth_first_search(g, color) }

# 2nd puzzle
puts count_bags(g, "shiny gold")
