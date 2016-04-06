require 'spec_helper'

RSpec.describe 'BitmapEditor' do
  describe '#run' do
    it 'exits when command X is given' do
      editor = BitmapEditor.new

      stubbed_gets = double
      expect(editor).to receive(:gets).and_return(stubbed_gets)
      expect(stubbed_gets).to receive(:chomp).and_return('X')

      expect { editor.run }.to output(/goodbye/).to_stdout
    end
  end

  describe '#parse_input' do
    context 'with command "I" given' do
      it 'creates a new image, with the provided width and height' do
        editor = BitmapEditor.new

        editor.parse_input('I 4 2')

        expect(editor.image.width).to eql 4
        expect(editor.image.height).to eql 2

        expected_image = "OOOO\nOOOO\n"

        expect(editor.image.to_s).to eql expected_image
      end
    end

    context 'with command "C" given' do
      it 'clears the image' do
        editor = BitmapEditor.new
        editor.parse_input('I 1 1')

        expect(editor.image).to receive(:clear!).once

        editor.parse_input('C')
      end
    end

    context 'when colouring a pixel with the "L" command' do
      it 'calls set_pixel on the image' do
        editor = BitmapEditor.new
        editor.parse_input('I 3 3')

        expect(editor.image).to receive(:set_pixel).with(2, 2, 'A').once

        editor.parse_input('L 2 2 A') # middle pixel
      end
    end

    context 'when colouring a vertical segment with the "V" command' do
      it 'calls set_vertical_segment on the image' do
        editor = BitmapEditor.new
        editor.parse_input('I 4 4')

        expect(editor.image).to receive(:set_vertical_segment).with(1, 2, 3, 'A').once

        editor.parse_input('V 1 2 3 A')
      end
    end

    context 'when colouring a horizontal segment with the "H" command' do
      it 'calls set_horizontal_segment on the image' do
        editor = BitmapEditor.new
        editor.parse_input('I 4 4')

        expect(editor.image).to receive(:set_horizontal_segment).with(1, 4, 3, 'B').once

        editor.parse_input('H 1 4 3 B')
      end
    end

    context 'with command "S" given' do
      it 'displays the bitmap in the console' do
        editor = BitmapEditor.new
        editor.parse_input('I 5 2')

        expect { editor.parse_input('S') }.to output("OOOOO\nOOOOO\n").to_stdout
      end
    end

    context 'with command "?" given' do
      it 'shows the help message' do
        editor = BitmapEditor.new
        expect(editor).to receive(:show_help).once

        editor.parse_input('?')
      end
    end

    context 'with command "X" given' do
      it 'exits the program' do
        editor = BitmapEditor.new
        expect(editor).to receive(:exit_console).once

        editor.parse_input('X')
      end
    end

    context 'with a lowercased command given' do
      it 'cleans up the command input and parses it normally' do
        editor = BitmapEditor.new
        expect(editor).to receive(:exit_console).once

        editor.parse_input('   x   ')
      end
    end
  end
end
