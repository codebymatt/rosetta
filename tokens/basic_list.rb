# frozen_string_literal: true

require './tokens/block_token'

# Handles logic for Paragraph tokens
class BasicList < BlockToken
  def type
    :BASIC_LIST
  end
end
