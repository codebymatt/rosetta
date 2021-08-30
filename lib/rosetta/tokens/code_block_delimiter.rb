# frozen_string_literal: true

require './lib/rosetta/tokens/basic_token'

# Handles logic for Header tokens
class CodeBlockDelimiter < BasicToken
  def self.matches?(text)
    text == '```'
  end

  def type
    :CODE_BLOCK_DELIMITER
  end

  def value
    nil
  end
end
