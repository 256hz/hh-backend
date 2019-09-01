require 'rails_helper'

RSpec.describe Color do
  context 'When making a random color' do
    random_color = Color.random_hex
    it 'will generate a 6 char string (3 digit hex)' do
      expect(random_color.length).to eq(6)
      expect(random_color.class.name).to eq('String')
      expect(random_color.match(/[\da-f]+/).string.length).to eq(6)
    end
  end

  context 'When normalizing the color' do
    normalized_color = Color.normalize_color(Color.random_hex)

    it 'will return an array with 3 items' do
      expect(normalized_color.length).to be(3)
    end

    it 'all items will be integers between 0-6' do
      normalized_color.each do |color|
        expect(color.class.name).to eq('Integer')
        expect(color).to be >= 0
        expect(color).to be <= 6
      end
    end
  end

  context 'When finding the color\'s family' do
    new_color = Color.random_hex
    color_anchors = Color::COLOR_ANCHORS.map { |a| a.keys[0] }
    family, relative_color = Color.find_color_family(new_color)

    it 'will return a string' do
      expect(family.class.name).to eq('String')
    end

    it 'the string will be one of the expected color categories' do
      expect(color_anchors).to include(family)
    end

    it 'the relative_color output will match the normalized_color' do
      expect(relative_color).to eq(Color.normalize_color(new_color))
    end
  end
end
