# frozen_string_literal: true

require './tokens/basic_token'
require 'byebug'

# Handles logic for Strikethrough tokens
class Strikethrough < BasicToken
  DELIMITER_TOKEN = '~~'

  def self.delimiter_length
    DELIMITER_TOKEN.length
  end

  def self.matches?(text)
    text.start_with?(DELIMITER_TOKEN) && valid_delimiter?(text[delimiter_length..])
  end

  def self.valid_delimiter?(text)
    delimiter_index = text.index(DELIMITER_TOKEN)
    !delimiter_index.nil?
  end

  def self.consume(raw_text)
    # Add an extra 1 to offset the extra delimiter length (because strikethrough).
    delimiter_index = raw_text[delimiter_length..].index(DELIMITER_TOKEN) + delimiter_length + 1

    source = raw_text[0..delimiter_index]
    new(source)
  end

  def type
    :STRIKETHROUGH
  end

  def value
    return DELIMITER_TOKEN * 2 if @source_text == DELIMITER_TOKEN * 2

    @source_text[self.class.delimiter_length...-self.class.delimiter_length]
  end
end
