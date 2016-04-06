class Image
  attr_reader :width, :height, :image

  def initialize(width, height)
    @width = Integer(width)
    @height = Integer(height)

    @image = Array.new(@height) { Array.new(@width, 'O') }
  end

  def set_pixel(x, y, colour)
    px = Integer(x) - 1
    py = Integer(y) - 1

    @image[py][px] = colour
  end

  def clear!
    @image = Array.new(@height) { Array.new(@width, 'O') }
  end

  def to_s
    @image.map{ |row| row.join }.join("\n") + "\n"
  end
end
