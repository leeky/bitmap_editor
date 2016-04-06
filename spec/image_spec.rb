require 'spec_helper'

RSpec.describe 'Image' do
  describe '#initialize' do
    it 'creates a new image with the given size' do
      image = Image.new(5, 5)

      expect(image.to_s).to eql "OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO"
    end
  end

  describe '#set_pixel' do
    it 'sets a pixel to a given value' do
      image = Image.new(3, 3)

      image.set_pixel(2, 2, 'A') # Middle pixel
      image.set_pixel(1, 3, 'B') # Bottom-left pixel

      expect(image.to_s).to eql "OOO\nOAO\nBOO"
    end
  end

  describe '#to_s' do
    it 'formats the image so it can be displayed in the console' do
      image = Image.new(3, 3)

      expect(image.to_s).to eql "OOO\nOOO\nOOO"
    end
  end
end
