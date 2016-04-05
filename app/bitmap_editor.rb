class BitmapEditor
  attr_reader :width, :height, :image

  def run
    @running = true
    puts 'type ? for help'

    while @running
      print '> '
      parse_input
    end
  end

  def parse_input(input = gets.chomp)
    command, *params = input.upcase.strip.split(' ')

    case command
    when 'I'
      create_image!(params[0], params[1])
    when 'L'
      set_pixel(params[0], params[1], params[2])
    when '?'
      show_help
    when 'X'
      exit_console
    else
      puts 'unrecognised command :('
    end
  end

  private

  def create_image!(width, height)
    @width = Integer(width)
    @height = Integer(height)

    @image = Array.new(@height) { Array.new(@width, 'O') }
  end

  def set_pixel(x, y, colour)
    px = Integer(x) - 1
    py = Integer(y) - 1

    @image[py][px] = colour
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
