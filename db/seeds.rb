Color.destroy_all

def absolute_colors
  {
    [6, 4, 2] => 'orange',  [5, 3, 1] => 'orange',
    
    [4, 2, 1] => 'brown',   [2, 1, 0] => 'brown',

    [4, 2, 6] => 'purple',  [4, 2, 4] => 'purple',  [3, 1, 5] => 'purple',
    [3, 1, 3] => 'purple',  [2, 0, 4] => 'purple',

    [2, 0, 0] => 'red',     [3, 1, 1] => 'red',     [4, 2, 2] => 'red',
    [5, 3, 3] => 'red',     [6, 4, 4] => 'red',
    [4, 0, 0] => 'red',     [6, 2, 2] => 'red',     [6, 0, 0] => 'red',

    [2, 2, 0] => 'yellow',  [3, 3, 1] => 'yellow',  [4, 4, 2] => 'yellow',
    [5, 5, 3] => 'yellow',  [6, 6, 4] => 'yellow',
    [4, 4, 0] => 'yellow',  [6, 6, 2] => 'yellow',  [6, 6, 0] => 'yellow',

    [0, 2, 0] => 'green',   [1, 3, 1] => 'green',   [2, 4, 2] => 'green',
    [3, 5, 3] => 'green',   [4, 6, 4] => 'green',
    [0, 4, 0] => 'green',   [2, 6, 2] => 'green',   [0, 6, 0] => 'green',

    [0, 0, 2] => 'blue',    [1, 1, 3] => 'blue',    [2, 2, 4] => 'blue',
    [3, 3, 5] => 'blue',    [4, 4, 6] => 'blue',
    [0, 0, 4] => 'blue',    [2, 2, 6] => 'blue',    [0, 0, 6] => 'blue',

    [0, 0, 0] => 'gray',    [1, 1, 1] => 'gray',    [2, 2, 2] => 'gray',
    [3, 3, 3] => 'gray',    [4, 4, 4] => 'gray',    [5, 5, 5] => 'gray',
    [6, 6, 6] => 'gray'
  }
end

def normalize_color(hex_color)
  r, g, b, = hex_color[0..1].hex, hex_color[2..3].hex, hex_color[4..5].hex
  # min_value = [r, g, b].min
  # max_value = [r, g, b].max
  r, g, b = [r, g, b].map do |color|
    color / 42
  end
  [r, g, b]
end

def find_color_family(hex_color)
  r, g, b = normalize_color(hex_color)
  minimum_distance = [6, 6, 6]
  closest_color = 'not assigned'
  absolute_colors.each do |color, name|
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

500.times do
  color_value = SecureRandom.hex(3)
  color_family, relative_color = find_color_family(color_value)
  Color.create!(hex: color_value, family: color_family, relative_color: relative_color.to_s)
end
