# frozen_string_literal: true

require './lib/rosetta/tokens/basic_token'

# Handles logic for Line Break tokens
class LineBreak < BasicToken
  def self.matches?(text)
    text == ''
  end

  def type
    :LINE_BREAK
  end

  def value
    nil
  end
end
