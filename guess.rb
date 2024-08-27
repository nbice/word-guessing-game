require_relative '5_letter_words'
require 'rainbow/refinement'
using Rainbow

class Guess
  attr_accessor :user_guess
  attr_accessor :character_map
  attr_accessor :valid
  attr_accessor :answer

  def initialize(answer)
    @character_map = {}
    @valid = false
    @answer = answer
  end

  def update_word(word)
    @user_guess = word

    while !verify_input
      puts 'Invalid input. Try again:'
      @user_guess = gets.chop
    end
  end

  def verify_input
    @user_guess&.length == 5 && DICTIONARY.include?(@user_guess)
  end

  def set_character_count(char, count)
    instance_variable_set(:"@#{char}_count", count)
  end

  def get_character_count(char)
    instance_variable_get(:"@#{char}_count")
  end

  def reset_instance_vars
    @user_guess.each_char{ |char_x|
      set_character_count(char_x, 0)
    }
  end

  def assign_char_values
    i = 0

    @user_guess.each_char{ |char_x|
      length_of_chars_in_answer = @answer.chars.select{|c| char_x == c }.length
      set_character_count(char_x, get_character_count(char_x) + 1)

      if @answer[i] == char_x
        @character_map[i] = {
          valid: true,
          char: char_x.green
        }
      elsif @answer.include?(char_x) && get_character_count(char_x) <= length_of_chars_in_answer && !other_valid_chars?(char_x, i)
        @character_map[i] = {
          valid: false,
          char: char_x.yellow
        }
      else
        @character_map[i] = {
          valid: false,
          char: char_x.red
        }
      end

      i += 1
    }
  end

  def other_valid_chars?(char, index)
    count = 0
    length_of_chars_in_answer = @answer[index, @answer.size].chars.select{|c| char == c }.length
    i = index

    @user_guess[index, @user_guess.size].each_char { |char_x|
      if char_x == char && char_x == @answer[i]#char
        count += 1
      end
      i += 1
    }

    0 < count && count <= length_of_chars_in_answer
  end

  def validate
    reset_instance_vars
    assign_char_values
    reset_instance_vars

    @valid = @character_map.select{|k,v| v[:valid] == false}.length == 0
  end

  def print_word
    str = ''
    @character_map.each{|k,v|
      str << v[:char]
    }
    puts str
  end
end