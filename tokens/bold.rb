# frozen_string_literal: true

require './tokens/basic_token'

# Handles logic for Bold tokens
class Bold < BasicToken
  def self.matches?(text)
    # TODO: Handle case where Bold token is start of line
    text.start_with?(' *') && valid_delimiter?(text[2..-1])
  end

  def self.valid_delimiter?(text)
    delimiter_index = text.index('*')
    return false if delimiter_index.nil? || preceding_whitespace?(text, delimiter_index)

    end_of_line?(text, delimiter_index) || trailing_whitespace?(text, delimiter_index)
  end

  def end_of_line?(text, delimiter_index)
    delimiter_index == text.length - 1
  end

  def self.trailing_whitespace?(text, delimiter_index)
    delimiter_index < text.length - 1 && [' ', "\t"].include?(text[delimiter_index + 1])
  end

  def self.preceding_whitespace?(text, delimiter_index)
    [' ', "\t"].include?(text[delimiter_index + 1])
  end

  def type
    :BOLD
  end

  def value
    # TODO
  end
end
