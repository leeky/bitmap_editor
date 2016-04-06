class Image
  attr_reader :width, :height, :image

  def initialize(width, height)
    @width = Integer(width)
    @height = Integer(height)

    @image = Array.new(@height) { Array.new(@width, 'O') }
  end

  def set_pixel(x, y, colour)
    return unless valid?(x, y)

    px = x - 1
    py = y - 1

    @image[py][px] = colour
  end

  def set_vertical_segment(x, y1, y2, colour)
    (y1..y2).each {|y| set_pixel(x, y, colour) }
  end

  def set_horizontal_segment(x1, x2, y, colour)
    (x1..x2).each {|x| set_pixel(x, y, colour) }
  end

  def clear!
    @image = Array.new(@height) { Array.new(@width, 'O') }
  end

  def to_s
    @image.map{ |row| row.join }.join("\n") + "\n"
  end

  private

  def valid?(x, y)
    x >= 1 && x <= self.width && y >= 1 && y <= self.height
  end
end
