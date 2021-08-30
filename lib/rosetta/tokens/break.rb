# frozen_string_literal: true

require './lib/rosetta/tokens/basic_token'

# Handles logic for Break tokens
class Break < BasicToken
  def self.matches?(text)
    text == ''
  end

  def initialize; end

  def type
    :BREAK
  end

  def value
    nil
  end
end
