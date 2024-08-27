require_relative 'guess'
require_relative '5_letter_words'

def word
  @word ||= DICTIONARY.sample
end

def start_game
  @round = 1
  @guess = Guess.new(word)

  puts 'Welcome to Wordle! You have 5 chances to correct the correct word.'
end

def get_guess
  puts 'Enter a 5 letter word and press enter to make your guess:'
  @guess.update_word(gets.chop)
end

def end_round
  if @guess.valid
    puts 'Congrats! You won the game!'
    exit
  elsif @round == 5
    puts 'You lost the game :('
    puts "The word is #{word}"
    exit
  else
    # puts "End of round #{@round}. #{5-@round} guesses left."
    @round += 1
  end
end

def execute!
  start_game
  
  while @round <= 5
    get_guess
    @guess.validate
    @guess.print_word
    end_round
  end

  puts 'Thanks for playing.'
end

execute!
