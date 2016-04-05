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
end
