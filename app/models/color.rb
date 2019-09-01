# frozen_string_literal: true

# Color model holds color name constants and color family picking methods
class Color < ApplicationRecord
  ORANGE = 'orange'
  BROWN = 'brown'
  PURPLE = 'purple'
  RED = 'red'
  YELLOW = 'yellow'
  GREEN = 'green'
  BLUE = 'blue'
  GRAY = 'gray'

  ABSOLUTE_COLORS = {
    [6, 4, 2] => ORANGE,  [5, 3, 1] => ORANGE,  [6, 5, 2] => ORANGE,
    [6, 5, 3] => ORANGE,  [5, 3, 2] => ORANGE,  [5, 4, 2] => ORANGE,

    [4, 2, 1] => BROWN,   [3, 2, 1] => BROWN,   [2, 1, 0] => BROWN,
    [4, 2, 0] => BROWN,   [3, 2, 0] => BROWN,

    [4, 2, 6] => PURPLE,  [4, 2, 4] => PURPLE,  [3, 1, 5] => PURPLE,
    [3, 1, 3] => PURPLE,  [2, 0, 4] => PURPLE,
    
    [0, 0, 0] => GRAY,    [1, 1, 1] => GRAY,    [2, 2, 2] => GRAY,
    [3, 3, 3] => GRAY,    [4, 4, 4] => GRAY,    [5, 5, 5] => GRAY,
    [6, 6, 6] => GRAY,

    [2, 2, 0] => YELLOW,  [3, 3, 1] => YELLOW,  [4, 4, 2] => YELLOW,
    [5, 5, 3] => YELLOW,  [6, 6, 4] => YELLOW,
    [4, 4, 0] => YELLOW,  [6, 6, 2] => YELLOW,  [6, 6, 0] => YELLOW,

    [2, 0, 0] => RED,     [3, 1, 1] => RED,     [4, 2, 2] => RED,
    [5, 3, 3] => RED,     [6, 4, 4] => RED,
    [4, 0, 0] => RED,     [6, 2, 2] => RED,     [6, 0, 0] => RED,

    [0, 2, 0] => GREEN,   [1, 3, 1] => GREEN,   [2, 4, 2] => GREEN,
    [3, 5, 3] => GREEN,   [4, 6, 4] => GREEN,
    [0, 4, 0] => GREEN,   [2, 6, 2] => GREEN,   [0, 6, 0] => GREEN,

    [0, 0, 2] => BLUE,    [1, 1, 3] => BLUE,    [2, 2, 4] => BLUE,
    [3, 3, 5] => BLUE,    [4, 4, 6] => BLUE,
    [0, 0, 4] => BLUE,    [2, 2, 6] => BLUE,    [0, 0, 6] => BLUE,
  }

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
    ABSOLUTE_COLORS.each do |color, name|
      r_distance = (r - color[0]).abs
      g_distance = (g - color[1]).abs
      b_distance = (b - color[2]).abs
      color_distance = r_distance + g_distance + b_distance
      if color_distance < minimum_distance.sum
        minimum_distance = [r_distance, g_distance, b_distance]
        closest_color = name
      end
    end
    relative_color = [r, g, b]
    [closest_color, relative_color]
  end

  def self.generate(amount)
    amount.times do
      color_value = SecureRandom.hex(3)
      color_family, relative_color = find_color_family(color_value)
      create!(hex: color_value, family: color_family, relative_color: relative_color.to_s)
    end
  end

end
