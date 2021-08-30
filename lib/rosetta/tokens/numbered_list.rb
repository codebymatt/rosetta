# frozen_string_literal: true

require './lib/rosetta/tokens/block_token'

# Handles logic for Paragraph tokens
class NumberedList < BlockToken
  def type
    :NUMBERED_LIST
  end
end
