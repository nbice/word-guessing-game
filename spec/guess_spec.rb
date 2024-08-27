require 'rspec'
require_relative '../guess'

describe 'Guess' do
  let(:guess) { Guess.new('world') }

  context '#initialize' do
    it 'initialized a guess with the given word' do
      expect(guess.answer).to eq('world')
    end
  end

  context '#update_word' do
    it 'updates user_guess' do
      guess.update_word('hello')
      expect(guess.user_guess).to eq('hello')
    end

    xit 'validates input' do
      allow(STDIN).to receive(:gets).and_return('world')
      expect {
        guess.update_word('hellos')
      }.to output('Invalid input. Try again:').to_stdout
    end
  end

  xcontext '#verify_input' do
    context 'verifies the length of the user_guess' do
      it 'with a valid input' do
        allow(guess).to receive(:user_guess).and_return('hello')
        expect(guess.verify_input).to be true
      end

      it 'with an invalid input' do
        allow(guess).to receive(:user_guess).and_return('invalid')
        expect(guess.verify_input).to be false
      end
    end
  end

  xcontext '#assign_char_values' do
    before do
      guess.update_word('hello')
    end

    it 'assings correct letters as green' do

    end

    it 'assings misplaces letters as yellow' do

    end

    it 'assings incorrect letters as red' do

    end
  end
end