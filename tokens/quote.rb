# frozen_string_literal: true

require './tokens/token'

# Handles logic for Header tokens
class Quote < Token
  def self.matches?(text)
    text.start_with?('> ')
  end

  def type
    :QUOTE
  end

  def value
    @value ||= extract_value_from_text
  end

  private

  def extract_value_from_text
    @source_text.delete_prefix('> ')
  end
end
