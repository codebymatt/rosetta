# frozen_string_literal: true

# Handles logic for Header tokens
class Header
  def initialize(source_text)
    @source_text = source_text
    @depth = self.class.determine_header_depth(@source_text)
  end

  def type
    "HEADER_#{@depth}".to_sym
  end

  def extract_value_from_text
    prefix = "#{'#' * @depth} "
    @source_text.delete_prefix(prefix)
  end

  def self.header?(text)
    depth = determine_header_depth(text)

    return false if depth > 6

    # If the '#' sequence is followed by an
    # empty string, we have a header!
    text[depth] == ' '
  end

  def self.determine_header_depth(text)
    depth = 0
    depth += 1 while text[depth] == '#'
    depth
  end
end
