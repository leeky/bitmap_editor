require_relative './image'

class BitmapEditor
  attr_reader :image

  def run
    @running = true
    puts 'type ? for help'

    while @running
      print '> '
      parse_input
    end
  end

  def parse_input(input = gets.chomp)
    command, *params = cleanup(input)

    case command
    when 'I'
      @image = Image.new(params[0], params[1])
    when 'C'
      @image.clear!
    when 'L'
      @image.set_pixel(params[0], params[1], params[2])
    when 'V'
      @image.set_vertical_segment(params[0], params[1], params[2], params[3])
    when 'H'
      @image.set_horizontal_segment(params[0], params[1], params[2], params[3])
    when 'S'
      puts @image.to_s
    when '?'
      show_help
    when 'X'
      exit_console
    else
      puts 'unrecognised command :('
    end
  end

  private

  def cleanup(input)
    input = input.upcase.strip.split(' ')

    input.map! do |value|
      if value.to_i.to_s == value
        Integer(value)
      else
        value
      end
    end
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end
end
