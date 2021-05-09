# frozen_string_literal: true

require './tokens/token'

# Handles logic for Header tokens
class NumberedListItem < Token
  def self.matches?(text)
    return false unless number?(text[0])

    text[1..2] == '. '
  end

  def type
    :NUMBERED_LIST_ITEM
  end

  def value
    # If the code reaches here we know the first 3 chars are the list delimiter.
    @source_text[3..-1]
  end

  def self.number?(object)
    object.to_s == object.to_i.to_s
  end
end
