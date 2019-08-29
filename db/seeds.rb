require 'securerandom'
Color.destroy_all

100.times do
  color_value = SecureRandom.hex(3)
  Color.create!(hex: color_value)
end
