# frozen_string_literal: true

require './tokens/token'

# Handles logic for Line Break tokens
# TODO: Finish.
class Link < Token
  def self.matches?(text)
    text == ''
  end

  def type
    :LINK
  end

  def value
    ''
  end

  def url
    ''
  end
end
