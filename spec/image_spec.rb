require 'spec_helper'

RSpec.describe 'Image' do
  describe '#initialize' do
    it 'creates a new image with the given size' do
      image = Image.new(5, 5)

      expect(image.to_s).to eql "OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\n"
      expect(image.width).to eql 5
      expect(image.height).to eql 5
    end

    it 'restricts the maximum width to 250' do
      image = Image.new(251, 5)

      expect(image.width).to eql 250
    end

    it 'restricts the maximum height to 250' do
      image = Image.new(1, 251)

      expect(image.height).to eql 250
    end

    it 'prevents negative-sized images from being created' do
      image = Image.new(-4, -2)

      expect(image.width).to eql 1
      expect(image.height).to eql 1
    end
  end

  describe '#set_pixel' do
    it 'sets a pixel to a given value' do
      image = Image.new(3, 3)

      image.set_pixel(2, 2, 'A') # Middle pixel
      image.set_pixel(1, 3, 'B') # Bottom-left pixel

      expect(image.to_s).to eql "OOO\nOAO\nBOO\n"
    end

    it 'ignores pixels that are outside of the image bounds' do
      image = Image.new(3, 3)

      image.set_pixel(0, 0, 'A')
      image.set_pixel(4, 0, 'A')
      image.set_pixel(0, 4, 'A')
      image.set_pixel(-1, -1, 'A')

      expect(image.to_s).to eql "OOO\nOOO\nOOO\n"
    end
  end

  describe '#set_vertical_segment' do
    it 'sets all pixels in the segment to the given colour' do
      image = Image.new(4, 4)

      image.set_vertical_segment(1, 1, 4, 'S')
      image.set_vertical_segment(3, 2, 3, 'T')

      expected_image = "SOOO\nSOTO\nSOTO\nSOOO\n"
      expect(image.to_s).to eql expected_image
    end
  end

  describe '#set_horizontal_segment' do
    it 'sets all pixels in the segment to the given colour' do
      image = Image.new(4, 4)

      image.set_horizontal_segment(1, 4, 3, 'A')

      expected_image = "OOOO\nOOOO\nAAAA\nOOOO\n"
      expect(image.to_s).to eql expected_image
    end
  end

  describe '#clear!' do
    it 'clears the image' do
      image = Image.new(2, 2)

      image.set_pixel(1, 1, 'A')
      image.set_pixel(2, 2, 'B')

      image.clear!

      expect(image.to_s).to eql "OO\nOO\n"
    end
  end

  describe '#to_s' do
    it 'formats the image so it can be displayed in the console' do
      image = Image.new(3, 3)

      expect(image.to_s).to eql "OOO\nOOO\nOOO\n"
    end
  end
end
