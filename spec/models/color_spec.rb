require 'rails_helper'

RSpec.describe Color, type: :model do
  c = Color
  context 'When generating a new color' do
    it 'will first generate a 3-digit (6 char) hex string' do
      random_color = c.random_hex
      expect(random_color).length to be(6)
      expect(random_color).to match(/str/)
      random_color.split('').each do |char|
        expect(char).to match(/0-9a-f/)
      end
    end
  end
end
