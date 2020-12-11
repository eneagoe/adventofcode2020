#!/usr/bin/env ruby -w

original = File.open(ARGV[0]).readlines.map(&:chomp).map(&:chars)
n, m = original.size, original[0].size

current = original.map { |line| line.clone }
next_round = Array.new(n) { Array.new(m) }

# 1st puzzle
unchanged = true

while unchanged
  (0...n).each do |i|
    (0...m).each do |j|
      next_round[i][j] = current[i][j]
      next if current[i][j] == "."
      if current[i][j] == "L"
        if [i > 0 && current[i - 1][j] == "#",
            i > 0 && j > 0 && current[i - 1][j - 1] == "#",
            i > 0 && j < m - 1 && current[i - 1][j + 1] == "#",
            j > 0 && current[i][j - 1] == "#",
            j < m - 1 && current[i][j + 1] == "#",
            i < n - 1 && j > 0 && current[i + 1][j - 1] == "#",
            i < n - 1 && current[i + 1][j] == "#",
            i < n - 1 && j  < m - 1 && current[i + 1][j + 1] == "#"
        ].count(&:itself).zero?
          next_round[i][j] = "#"
          unchanged = false
        end
      elsif current[i][j] == "#"
        if [i > 0 && current[i - 1][j] == "#",
            i > 0 && j > 0 && current[i - 1][j - 1] == "#",
            i > 0 && j < m - 1 && current[i - 1][j + 1] == "#",
            j > 0 && current[i][j - 1] == "#",
            j < m - 1 && current[i][j + 1] == "#",
            i < n - 1 && j > 0 && current[i + 1][j - 1] == "#",
            i < n - 1 && current[i + 1][j] == "#",
            i < n - 1 && j  < m - 1 && current[i + 1][j + 1] == "#"
          ].count(&:itself) >= 4
          next_round[i][j] = "L"
          unchanged = false
        end
      end
    end
  end

  break if unchanged

  current, next_round = next_round, current
  unchanged = true
end

puts current.flatten.count("#")

# 2nd puzzle
current = original.map { |line| line.clone }
next_round = Array.new(n) { Array.new(m) }
unchanged = true

first_unoccupied = lambda { |seats| seats.find { |x| x != "." } }

while unchanged
  (0...n).each do |i|
    (0...m).each do |j|
      next_round[i][j] = current[i][j]
      next if current[i][j] == "."

      north = (0...i).map { |k| current[k][j] }.reverse
      south = (i + 1...n).map { |k| current[k][j] }
      east = (0...j).map { |k| current[i][k] }.reverse
      west = (j + 1...m).map { |k| current[i][k] }

      nw = []
      k, l = i - 1, j - 1
      while k >= 0 && l >= 0
        nw << current[k][l]
        k -= 1
        l -= 1
      end

      ne = []
      k, l = i - 1, j + 1
      while k >= 0 && l < m
        ne << current[k][l]
        k -= 1
        l += 1
      end

      sw = []
      k, l = i + 1, j - 1
      while k < n && l >= 0
        sw << current[k][l]
        k += 1
        l -= 1
      end

      se = []
      k, l = i + 1, j + 1
      while k < n && l < m
        se << current[k][l]
        k += 1
        l += 1
      end

      if current[i][j] == "L"
        if [first_unoccupied.(north) == "#",
            first_unoccupied.(south) == "#",
            first_unoccupied.(east) == "#",
            first_unoccupied.(west) == "#",
            first_unoccupied.(nw) == "#",
            first_unoccupied.(sw) == "#",
            first_unoccupied.(ne) == "#",
            first_unoccupied.(se) == "#"].count(&:itself).zero?
          next_round[i][j] = "#"
          unchanged = false
        end
      elsif current[i][j] == "#"
        if [first_unoccupied.(north) == "#",
            first_unoccupied.(south) == "#",
            first_unoccupied.(east) == "#",
            first_unoccupied.(west) == "#",
            first_unoccupied.(nw) == "#",
            first_unoccupied.(sw) == "#",
            first_unoccupied.(ne) == "#",
            first_unoccupied.(se) == "#"].count(&:itself) >= 5
          next_round[i][j] = "L"
          unchanged = false
        end
      end
    end
  end

  break if unchanged

  current, next_round = next_round, current
  unchanged = true
end

puts current.flatten.count("#")
