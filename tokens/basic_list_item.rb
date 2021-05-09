# frozen_string_literal: true

require './tokens/token'

# Handles logic for Header tokens
class BasicListItem < Token
  def self.matches?(text)
    text.start_with?('* ') || text.start_with?('- ')
  end

  def type
    :BASIC_LIST_ITEM
  end

  def value
    # If the code reaches here we know the first 2 chars are the list delimiter.
    @source_text[2..-1]
  end
end
