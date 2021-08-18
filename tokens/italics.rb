# frozen_string_literal: true

require './tokens/basic_token'
require './tokens/shared/inline_tokens'

# Handles logic for Italics tokens
class Italics < BasicToken
  extend Shared::InlineTokens

  DELIMITER_TOKEN = '_'

  def type
    :STRIKETHROUGH
  end

  def value
    return DELIMITER_TOKEN * 2 if @source_text == DELIMITER_TOKEN * 2

    @source_text[self.class.delimiter_length...-self.class.delimiter_length]
  end
end
