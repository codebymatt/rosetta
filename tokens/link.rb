# frozen_string_literal: true

require './tokens/token'

# Handles logic for Link tokens
class Link < Token
  def self.matches?(text)
    # Naive check for standalone link.
    return false unless text[0] == '['

    closing_bracket_index = text.index(']')
    return false if closing_bracket_index.nil?

    return false if text[closing_bracket_index + 1] != '('

    text[-1] == ')'
  end

  def to_s
    "<Token type='#{type}' value='#{value}' url='#{url}'>"
  end

  def type
    :LINK
  end

  def value
    final_bracket_index = url_beginning_index - 1

    # We want the value inside brackets, and should exclude the brackets themselves.
    @source_text[1...final_bracket_index]
  end

  def url
    # We want the value inside the parenthesis, and should exclude the the parens themselves.
    @source_text[url_beginning_index + 1...-1]
  end

  private

  def url_beginning_index
    open_bracket_count = 0

    @url_beginning_index ||= @source_text.each_char.with_index do |character, index|
      case character
      when '['
        open_bracket_count += 1
      when ']'
        open_bracket_count -= 1
      end

      return index + 1 if open_bracket_count.zero?
    end
  end
end
