Color.destroy_all

# def absolute_colors
#   {
#     'ff0000'.hex => 'red',
#     'ff7f00'.hex => 'orange',
#     'ffff00'.hex => 'yellow',
#     '00ff00'.hex => 'green',
#     '0000ff'.hex => 'blue',
#     '7f00ff'.hex => 'purple',
#     '7f6027'.hex => 'brown'
#     # '7f7f7f'.hex => 'gray',
#     # 'ffffff'.hex => 'gray',
#     # '000000'.hex => 'gray'
#   }
# end

# def find_color_family(orphan_color)
#   minimum_distance = 'ffffff'.hex
#   closest_color = 'error'
#   absolute_colors.keys.each_with_index do |abs_color, i|
#     color_distance = (abs_color - orphan_color).abs
#     if color_distance < minimum_distance
#       minimum_distance = color_distance
#       closest_color = absolute_colors.values[i]
#     end
#   end
#   closest_color
# end

# def absolute_colors
#   {
#     [169, 64, 64] => 'red',
#     [169, 127, 64] => 'orange',
#     [169, 169, 64] => 'yellow',
#     [64, 169, 64] => 'green',
#     # [64, 169, 169] => 'teal',
#     [64, 64, 169] => 'blue',
#     [169, 64, 169] => 'purple',
#     [132, 100, 66] => 'brown',
#     [127, 127, 127] => 'gray',
#     [169, 169, 169] => 'gray_white',
#     [64, 64, 64] => 'gray_black'
#   }
# end

# def absolute_colors
#   {
#     [255, 127, 127] => 'red',
#     [255, 127, 0] => 'orange',
#     [255, 255, 0] => 'yellow',
#     [0, 255, 0] => 'green',
#     # [0, 255, 255] => 'teal',
#     [0, 0, 255] => 'blue',
#     [127, 0, 255] => 'purple',
#     [127, 64, 0] => 'brown',
#     [127, 127, 127] => 'gray'
#     # [255, 255, 255] => 'gray_white',
#     # [0, 0, 0] => 'gray_black'
#   }
# end

def absolute_colors
  {
    [2, 0, 0] => 'red',
    [4, 2, 2] => 'red',
    [6, 4, 4] => 'red',
    [6, 4, 2] => 'orange',
    [5, 3, 1] => 'orange',
    [2, 2, 0] => 'yellow',
    [4, 4, 2] => 'yellow',
    [6, 6, 4] => 'yellow',
    [0, 2, 0] => 'green',
    [2, 4, 2] => 'green',
    [4, 6, 4] => 'green',
    [0, 0, 2] => 'blue',
    [2, 2, 4] => 'blue',
    [4, 4, 6] => 'blue',
    [4, 2, 6] => 'purple',
    [4, 2, 4] => 'purple',
    [3, 1, 5] => 'purple',
    [3, 1, 3] => 'purple',
    [2, 0, 4] => 'purple',
    [4, 2, 1] => 'brown',
    [2, 1, 0] => 'brown',
    [1, 1, 1] => 'gray',
    [2, 2, 2] => 'gray',
    [3, 3, 3] => 'gray',
    [4, 4, 4] => 'gray',
    [5, 5, 5] => 'gray'
  }
end

def normalize_color(hex_color)
  r, g, b, = hex_color[0..1].hex, hex_color[2..3].hex, hex_color[4..5].hex
  min_value = [r, g, b].min
  max_value = [r, g, b].max
  r, g, b = [r, g, b].map do |color|
    ((color - min_value).to_f / (max_value - min_value) * 4).to_i
  end
  [r, g, b]
end

def find_color_family(hex_color)
  r, g, b = normalize_color(hex_color)
  minimum_distance = [5, 5, 5]
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
  closest_color
end

200.times do
  color_value = SecureRandom.hex(3)
  color_family = find_color_family(color_value)
  Color.create!(hex: color_value, family: color_family)
end
