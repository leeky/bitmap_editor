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

        expected_image =  "OOOO\nOOOO"

        expect(editor.image.to_s).to eql expected_image
      end
    end

    context 'when colouring a pixel with the "L" command' do
      it 'sets the relevant pixel to the given colour' do
        editor = BitmapEditor.new
        editor.parse_input('I 3 3')

        editor.parse_input('L 2 2 A') # middle pixel
        editor.parse_input('L 1 3 B') # bottom-left pixel

        expected_image = "OOO\nOAO\nBOO"
        expect(editor.image.to_s).to eql expected_image
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
