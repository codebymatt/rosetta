# frozen_string_literal: true

require './lib/rosetta/tokens/basic_token'

# Handles logic for New Line tokens
class NewLine < BasicToken
  def self.matches?(text)
    text == ''
  end

  def initialize; end

  def type
    :NEW_LINE
  end

  def value
    nil
  end
end
