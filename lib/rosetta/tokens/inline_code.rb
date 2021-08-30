# frozen_string_literal: true

require './lib/rosetta/tokens/basic_token'
require './lib/rosetta/tokens/shared/inline_tokens'

# Handles logic for Inline Code tokens
class InlineCode < BasicToken
  extend Shared::InlineTokens

  DELIMITER_TOKEN = '`'

  def self.delimiter_length
    DELIMITER_TOKEN.length
  end

  def type
    :INLINE_CODE
  end

  def value
    return DELIMITER_TOKEN * 2 if @source_text == DELIMITER_TOKEN * 2

    @source_text[self.class.delimiter_length...-self.class.delimiter_length]
  end
end
