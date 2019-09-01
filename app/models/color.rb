# frozen_string_literal: true

# Color model holds color name constants and color family picking methods
class Color < ApplicationRecord
  ORANGE = 'orange'
  BROWN = 'brown'
  PURPLE = 'purple'
  CYAN = 'cyan'
  RED = 'red'
  YELLOW = 'yellow'
  GREEN = 'green'
  BLUE = 'blue'
  GRAY = 'gray'

  COLOR_ANCHORS = [
    { ORANGE => [[6, 5, 2], [6, 5, 3], [6, 4, 2], [5, 4, 2], [5, 4, 1], [5, 4, 0],
                 [5, 3, 1], [5, 3, 2], [5, 2, 0]] },
    { BROWN =>  [[4, 3, 1], [4, 2, 1], [4, 2, 0], [3, 2, 1], [3, 2, 0], [2, 2, 0], 
                 [2, 1, 0], [1, 1, 0]] },
    { PURPLE => [[6, 4, 6], [6, 2, 6], [6, 0, 6], [4, 2, 6], [4, 2, 4], [4, 1, 4],
                 [3, 1, 5], [3, 1, 3], [2, 0, 4], [2, 0, 3], [2, 0, 2], [2, 0, 1]] },
    { CYAN =>   [[4, 6, 6], [2, 6, 6], [2, 5, 4], [0, 6, 6], [3, 5, 5], [1, 5, 5],
                 [0, 4, 4], [0, 3, 3], [0, 2, 2], [0, 1, 1]] },
    { GRAY =>   [[6, 6, 6], [5, 5, 5], [4, 4, 4], [3, 3, 3], [3, 3, 2], [2, 2, 2],
                 [1, 1, 1], [0, 0, 0]] },
    { YELLOW => [[6, 6, 4], [6, 6, 2], [6, 6, 0], [5, 6, 1], [5, 5, 3], [5, 5, 2],
                 [5, 5, 1], [5, 5, 0], [4, 5, 2], [4, 5, 1], [4, 5, 0], [4, 4, 2],
                 [4, 4, 1], [4, 4, 0], [3, 4, 0]] },
    { RED =>    [[6, 4, 4], [6, 2, 2], [6, 0, 0], [5, 1, 1], [5, 3, 3], [4, 2, 2],
                 [4, 1, 0], [4, 0, 0], [3, 1, 1], [2, 0, 0]] },
    { GREEN =>  [[4, 6, 4], [4, 5, 1], [4, 5, 0], [3, 5, 3], [3, 5, 0], [3, 4, 1],
                 [3, 4, 0], [3, 3, 1], [2, 6, 2], [2, 4, 2], [2, 4, 0], [2, 3, 0],
                 [2, 3, 1], [2, 2, 0], [1, 4, 1], [1, 3, 1], [1, 2, 0], [0, 6, 0],
                 [0, 4, 0], [0, 2, 0], [0, 1, 0]] },
    { BLUE =>   [[4, 4, 6], [3, 3, 6], [3, 3, 5], [2, 2, 6], [2, 2, 5], [2, 2, 4],
                 [1, 1, 4], [1, 0, 5], [1, 1, 3], [1, 0, 4], [1, 1, 2], [0, 0, 6],
                 [0, 0, 4], [0, 0, 2]] }
    ].freeze

  def self.normalize_color(hex_color)
    r, g, b, = hex_color[0..1].hex, hex_color[2..3].hex, hex_color[4..5].hex
    r, g, b = [r, g, b].map do |color|
      color / 42
    end
    [r, g, b]
  end

  def self.find_color_family(hex_color)
    r, g, b = normalize_color(hex_color)
    minimum_distance = [6, 6, 6]
    closest_color = 'not assigned'
    COLOR_ANCHORS.each do |anchor_set|
      name = anchor_set.keys.first
      anchor_set.values.first.each do |color|
        r_distance = (r - color[0]).abs
        g_distance = (g - color[1]).abs
        b_distance = (b - color[2]).abs
        color_distance = r_distance + g_distance + b_distance
        if color_distance <= minimum_distance.sum
          minimum_distance = [r_distance, g_distance, b_distance]
          closest_color = name
        end
      end
    end
    relative_color = [r, g, b]
    [closest_color, relative_color]
  end

  def self.random_hex
    SecureRandom.hex(3)
  end

  def self.generate(amount)
    amount.times do
      color_value = random_hex
      color_family, relative_color = find_color_family(color_value)
      create!(hex: color_value, family: color_family, relative_color: relative_color.to_s)
    end
  end

end