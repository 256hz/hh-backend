Color.destroy_all

def absolute_colors
  {
    'red' => [255, 0, 0],
    'orange' => [255, 127, 0],
    'yellow' => [255, 255, 0],
    'green' => [0, 255, 0],
    'blue' => [0, 0, 255],
    'purple' => [127, 0, 255],
    'brown' => [127, 96, 40],
    'gray' => [127, 127, 127]
  }
end

def color_family(hex)
  r, g, b = hex[0..1].hex, hex[2..3].hex, hex[4..5].hex
end

100.times do
  color_value = SecureRandom.hex(3)
  Color.create!(hex: color_value)
end
