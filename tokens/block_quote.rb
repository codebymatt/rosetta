# frozen_string_literal: true

require './tokens/block_token'

# Handles logic for Paragraph tokens
class BlockQuote < BlockToken
  def type
    :BLOCK_QUOTE
  end
end
