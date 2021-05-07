# frozen_string_literal: true

require './tokens/token'

# Handles logic for Header tokens
class Header < Token
  def self.matches?(text)
    return false unless text[0] == '#'

    text.chars.each do |char|
      next if char == '#'

      return char == ' '
    end
  end

  def initialize(source_text)
    super(source_text)
    @depth = determine_depth
  end

  def type
    "HEADER_#{@depth}".to_sym
  end

  def value
    @value ||= extract_value_from_text
  end

  private

  def extract_value_from_text
    prefix = "#{'#' * @depth} "
    @source_text.delete_prefix(prefix)
  end

  def determine_depth
    depth = 0
    depth += 1 while @source_text[depth] == '#'
    depth
  end
end
