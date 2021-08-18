# frozen_string_literal: true

require './tokens/basic_token'
require './tokens/shared/inline_tokens'

# Handles logic for Strikethrough tokens
class Strikethrough < BasicToken
  extend Shared::InlineTokens

  DELIMITER_TOKEN = '~~'

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
