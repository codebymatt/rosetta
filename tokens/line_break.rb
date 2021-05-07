# frozen_string_literal: true

require './tokens/token'

# Handles logic for Line Break tokens
class LineBreak < Token
  def self.matches?(text)
    text == ''
  end

  def type
    :LINE_BREAK
  end

  def value
    ''
  end
end
