Color.destroy_all

500.times do
  color_value = SecureRandom.hex(3)
  color_family, relative_color = Color.find_color_family(color_value)
  Color.create!(hex: color_value, family: color_family, relative_color: relative_color.to_s)
end
